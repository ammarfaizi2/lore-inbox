Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317142AbSG1TPE>; Sun, 28 Jul 2002 15:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317152AbSG1TPE>; Sun, 28 Jul 2002 15:15:04 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:24581 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317142AbSG1TPD>; Sun, 28 Jul 2002 15:15:03 -0400
Date: Sun, 28 Jul 2002 20:18:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] fs/binfmt_aout.c: Use PAGE_ALIGN_LL() on 64-bit values
Message-ID: <20020728201821.A16713@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Anton Altaparmakov <aia21@cantab.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <E17YRsD-0006Hw-00@storm.christs.cam.ac.uk> <E17YRsD-0006Hw-00@storm.christs.cam.ac.uk> <m1wurfhgxd.fsf@frodo.biederman.org> <5.1.0.14.2.20020728194633.04207dd0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5.1.0.14.2.20020728194633.04207dd0@pop.cus.cam.ac.uk>; from aia21@cantab.net on Sun, Jul 28, 2002 at 07:55:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 07:55:51PM +0100, Anton Altaparmakov wrote:
> I thought (intel) CPUs did 48-bit addressing? How do we support 32GiB of 
> RAM? With pure 32-bit addressing it would be limited to 4GiB only... No? 
> (Of course I am probably confusing varius types of addresses...)

P6+ support 36bit _physical_ addressing.

