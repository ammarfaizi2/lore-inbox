Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310325AbSCLEli>; Mon, 11 Mar 2002 23:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310357AbSCLElU>; Mon, 11 Mar 2002 23:41:20 -0500
Received: from codepoet.org ([166.70.14.212]:32686 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S310325AbSCLElK>;
	Mon, 11 Mar 2002 23:41:10 -0500
Date: Mon, 11 Mar 2002 21:41:12 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "J. Dow" <jdow@earthlink.net>, Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020312044112.GA18857@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	"J. Dow" <jdow@earthlink.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203111741310.8121-100000@home.transmeta.com> <3C8D667F.5040208@mandrakesoft.com> <01a401c1c970$aeb74110$1125a8c0@wednesday> <3C8D71AC.3080305@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C8D71AC.3080305@mandrakesoft.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.18-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Mar 11, 2002 at 10:10:36PM -0500, Jeff Garzik wrote:
> 1) There should be a raw device command interface (not ATA or SCSI specific)

Hmm.  If such a generic low-level raw device layer were to be
implemented (presumably as the foundation for the block layer), I
expect the interface would be somthing like the cdrom layer, and
would abstract out all the normal things that raw mass-storage
devices can do.

But the minute such a layer is in place, people will begin going
straight to the sub-low-level raw device layers so they can use
all the exciting new extended features of their XP370000 quantum
storage array which needs the special frob-electrons command to
make it work...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
