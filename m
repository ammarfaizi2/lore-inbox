Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310437AbSCLGaG>; Tue, 12 Mar 2002 01:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310439AbSCLG3s>; Tue, 12 Mar 2002 01:29:48 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:2972 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S310437AbSCLG33>; Tue, 12 Mar 2002 01:29:29 -0500
Message-ID: <01f401c1c98f$3f9748b0$1125a8c0@wednesday>
From: "J. Dow" <jdow@earthlink.net>
To: <andersen@codepoet.org>, "Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: "Linus Torvalds" <torvalds@transmeta.com>,
        "LKML" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203111741310.8121-100000@home.transmeta.com> <3C8D667F.5040208@mandrakesoft.com> <01a401c1c970$aeb74110$1125a8c0@wednesday> <3C8D71AC.3080305@mandrakesoft.com> <20020312044112.GA18857@codepoet.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Date: Mon, 11 Mar 2002 22:29:22 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Erik Andersen" <andersen@codepoet.org>

> On Mon Mar 11, 2002 at 10:10:36PM -0500, Jeff Garzik wrote:
> > 1) There should be a raw device command interface (not ATA or SCSI specific)
>
> Hmm.  If such a generic low-level raw device layer were to be
> implemented (presumably as the foundation for the block layer), I
> expect the interface would be somthing like the cdrom layer, and
> would abstract out all the normal things that raw mass-storage
> devices can do.
>
> But the minute such a layer is in place, people will begin going
> straight to the sub-low-level raw device layers so they can use
> all the exciting new extended features of their XP370000 quantum
> storage array which needs the special frob-electrons command to
> make it work...

Erik, that is precisely the point on which the Amiga discussions of
the Direct SCSI command capability in scsi device drivers fell down.
(Due to historical oddities even IDE device drivers feature the direct
SCSI interface via emulation. It seems like an ultimate horror. However
it has enabled some marvelously generic tools.)

{^_^}


