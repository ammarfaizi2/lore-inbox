Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264371AbRFSQFn>; Tue, 19 Jun 2001 12:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264380AbRFSQFd>; Tue, 19 Jun 2001 12:05:33 -0400
Received: from mailf.telia.com ([194.22.194.25]:50900 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S264371AbRFSQF0>;
	Tue, 19 Jun 2001 12:05:26 -0400
Date: Tue, 19 Jun 2001 18:11:48 +0200
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: random errors with bzip2
Message-ID: <20010619181148.A24734@telia.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <lxiths7aqf.fsf@pixie.isr.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lxiths7aqf.fsf@pixie.isr.ist.utl.pt>
User-Agent: Mutt/1.3.18i
X-Unexpected-Header: The Spanish Inquisition
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rodrigo Ventura <yoda@isr.ist.utl.pt> wrote:

> - it could be a memory problem, but if it were, lots of kernel
> oops were expected, right?

This certainly sounds like a memory problem. I experienced almost the same
behaviour with a box some years ago, and it turned out to be memory. The
kernel didn't oops, and I actually had to run several kernel compiles at
the same time to have gcc die.

Try memtest86 on the suspect box.
-- 

André Dahlqvist <andre.dahlqvist@telia.com>
