Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267117AbTBQOBy>; Mon, 17 Feb 2003 09:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbTBQOBL>; Mon, 17 Feb 2003 09:01:11 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:42143 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S267076AbTBQN7p>; Mon, 17 Feb 2003 08:59:45 -0500
Date: Mon, 17 Feb 2003 09:09:44 -0500
To: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Make sysctl vm subdir dependent on CONFIG_MMU
Message-ID: <20030217140944.GA21202@gnu.org>
References: <20030217105900.5E2683728@mcspd15.ucom.lsi.nec.co.jp> <20030217125504.A25066@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217125504.A25066@infradead.org>
User-Agent: Mutt/1.3.28i
Blat: Foop
From: Miles Bader <miles@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 12:55:04PM +0000, Christoph Hellwig wrote:
> These ifdefs are ugly - please move the whole table into a file that
> isn't compiled when CONFIG_MMU isn't set (e.g. memory.c) and use
> register_sysctl_table()

Hmm, somehow I thought you were going to say that ... :-)

Either way is OK with me, but note that I just followed the style already
used in sysctl.c for CONFIG_NET.

-Miles
-- 
Saa, shall we dance?  (from a dance-class advertisement)
