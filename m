Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUFRLQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUFRLQy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 07:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbUFRLQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 07:16:54 -0400
Received: from smtp.dei.uc.pt ([193.137.203.228]:26087 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S265108AbUFRLQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 07:16:27 -0400
Date: Fri, 18 Jun 2004 12:12:51 +0100 (WEST)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: 4Front Technologies <dev@opensound.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Stop the linux kernel madness - SOLVED!
In-Reply-To: <40D25477.1050006@opensound.com>
Message-ID: <Pine.LNX.4.60.0406181208200.13171@student.dei.uc.pt>
References: <40D25477.1050006@opensound.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCTUC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCTUC-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 17 Jun 2004, 4Front Technologies wrote:

> Hi Folks,
>
> Here's the solution we have found:
>
> With the latest SuSE 2.6.5-7.75 kernel sources:
>
> The problem is that /lib/modules/2.6.5-7.75/build points to
> /usr/src/linux-2.6.5-7.75-obj which is some kind of wierd directory
> that has:
>
> .  ..  bigsmp  debug  default  out  smp
>
> So simply removing this symlink and putting back a link to
> /usr/src/linux-2.6.5-7.75 fixes our problems.
>
> So the question is who is at fault here?. We used KBUILD to
> build our modules and obviously the build link in /lib/modules/<kernel>/build
> isn't pointing to the correct source tree.

IF the fault here is SUSE's, then submit THEM a bug report and stop whining in lkml.
If you did your homework in the first place you would see that that's not a
Linux Kernel problem and would not start this whole discussion.

All you've managed with this was ening with any reputation 4Front Technologies
could have between lkml readers.


Mind Booster Noori

- -- 
/* ************************************************************************* */
    Marcos Daniel Marado Torres		AKA 		     Mind Booster Noori
    http://student.dei.uc.pt/~marado 	 - 	       marado@student.dei.uc.pt
() Join the ASCII ribbon campaign against html email and Microsoft attachments. 
/\ Software patents are endangering the computer industry all around the world.
    Join the LPF: 	http://lpf.ai.mit.edu/ 	 http://petition.eurolinux.org/ 
/* ************************************************************************* */
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFA0s43mNlq8m+oD34RAgx8AKDKlRG8j8ik3LFsjKDKsY4TnVkDcgCfUCoV
gajxf21QF9lJfYNW37d19Wg=
=eZ8j
-----END PGP SIGNATURE-----

