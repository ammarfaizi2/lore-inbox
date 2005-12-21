Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVLUI4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVLUI4q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 03:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVLUI4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 03:56:46 -0500
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]:47615 "EHLO
	BAYC1-PASMTP06.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932184AbVLUI4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 03:56:45 -0500
Message-ID: <BAYC1-PASMTP065003A7F9B2D70E84AE57AE310@CEZ.ICE>
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Message-ID: <52666.10.10.10.28.1135155403.squirrel@linux1>
In-Reply-To: <87psnqnb3z.fsf@amaterasu.srvr.nix>
References: <43A5F058.1060102@tlinx.org> <20051219071959.GJ13985@lug-owl.de>
    <87d5jru67j.fsf@amaterasu.srvr.nix>
    <20051220155839.GA9185@mars.ravnborg.org>
    <87irtjslxx.fsf@amaterasu.srvr.nix>
    <20051220202559.GK27946@ftp.linux.org.uk>
    <87psnqnb3z.fsf@amaterasu.srvr.nix>
Date: Wed, 21 Dec 2005 03:56:43 -0500 (EST)
Subject: Re: Makefile targets: tar & rpm pkgs,
      while using O=<dir> as non-root
From: "Sean" <seanlkml@sympatico.ca>
To: "Nix" <nix@esperi.org.uk>
Cc: "Al Viro" <viro@ftp.linux.org.uk>, "Sam Ravnborg" <sam@ravnborg.org>,
       "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       "Linda Walsh" <lkml@tlinx.org>
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 21 Dec 2005 08:57:08.0984 (UTC) FILETIME=[8656AF80:01C6060C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, December 21, 2005 2:49 am, Nix said:

> Well, personally I handle patch-application in cp -al'ed trees by doing
> cp -al via a script, and repatching all currently hardlinked trees
> (obviously if they are very divergent some patches will fail and I'll
> have to fix them up by hand).
>
> It works for me well enough to keep hardlinked branches going for in
> some cases years without problems.

Well the O= syntax is much nicer when using Git.   You symply checkout the
branch you're interested in and compile it; then switch to another,
compile it, etc...  Git makes checking out a brach lightning fast, it's
very slick.   Using the O= notation means you only have one branch checked
out at a time and there's no need to have source files linked to a bunch
of different directories.

Cheers,
Sean

