Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUBKEIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 23:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbUBKEIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 23:08:21 -0500
Received: from smtp2.dei.uc.pt ([193.137.203.229]:6803 "EHLO smtp2.dei.uc.pt")
	by vger.kernel.org with ESMTP id S262794AbUBKEIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 23:08:19 -0500
Date: Wed, 11 Feb 2004 04:08:11 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Critical problem in 2.6.2 and up
In-Reply-To: <20040210200220.32329bfd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0402110405260.28596@student.dei.uc.pt>
References: <Pine.LNX.4.58.0402110250580.28596@student.dei.uc.pt>
 <20040210191911.4d6e1308.akpm@osdl.org> <Pine.LNX.4.58.0402110325050.28596@student.dei.uc.pt>
 <Pine.LNX.4.58.0402110350240.28596@student.dei.uc.pt> <20040210200220.32329bfd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 10 Feb 2004, Andrew Morton wrote:

> "Marcos D. Marado Torres" <marado@student.dei.uc.pt> wrote:
> >
> >
> > With nbd disabled the patch causes no problems.
> >
>
> I don't know what LILO's problem is, frankly.  My version is OK with it,
> and my /proc/partitions is doing the same as yours.
>
> vmm:/home/akpm>  lilo -V
> LILO version 21.4-4

Well, I'm using version 22.5.8 (the last version)... Maybe you could update
LILO and see if that's what causes the problem?

> Still, we probably want to suppress all those NDB majors in
> /proc/partitions.  I'll discuss it with the blocky guys.
>


- --
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFAKaqumNlq8m+oD34RAkprAJ9lF/bAIpyyt3Hq1RS7nJeaeMZ5cwCePjih
otu5E51YY1c7dk53r7JQ/RE=
=iXC8
-----END PGP SIGNATURE-----

