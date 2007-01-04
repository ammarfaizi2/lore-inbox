Return-Path: <linux-kernel-owner+w=401wt.eu-S965079AbXADUX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbXADUX5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 15:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbXADUX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 15:23:57 -0500
Received: from hoefnix.telenet-ops.be ([195.130.132.54]:49966 "EHLO
	hoefnix.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965079AbXADUX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 15:23:57 -0500
Message-ID: <459D6239.7090601@telenet.be>
Date: Thu, 04 Jan 2007 21:23:21 +0100
From: Kristof Provost <Kristof.Provost@telenet.be>
Reply-To: Kristof.Provost@telenet.be
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Akula2 <akula2.shark@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multi kernel tree support on the same distro?
References: <8355959a0701041146v40da5d86q55aaa8e5f72ef3c6@mail.gmail.com>
In-Reply-To: <8355959a0701041146v40da5d86q55aaa8e5f72ef3c6@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

> Hello All,
> 
> I am looking to use multiple kernel trees on the same distro. Example:-
> 
> 2.6.19.1 for - software/tools development
> 2.4.34    for - embedded systems development.
> 
> I do know that 2.6 supports embedded in a big way....but still
> requirement demands to work with such boards as an example:-
> 
> http://www.embeddedarm.com/linux/ARM.htm
> 
> My question is HOW-TO enable a distro with multi kernel trees?
> Presently am using Fedora Core 5/6 for much of the development
> activities (Cell BE SDK related at Labs).
> 
> Any hints/suggestions would be a great leap for me to do this on my own.
> 
> ~Akula2

I'm not sure I understood your problem correctly.
I see no reason to have two kernel versions on your host system. You can
keep 2.6.x on the host, and compile a 2.4.x for the target. You don't
need to run 2.4.x on your host.

The TS-Kernel the website talks about is meant to run on the embedded
target.

Kristof
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFnWI5UEZ9DhGwDugRA/SCAKCgBfrAIreTa4k6IsmAi4Dr2jGa6wCfbTF7
CexlUWurRHI20hHsp+TsN5k=
=0kdG
-----END PGP SIGNATURE-----
