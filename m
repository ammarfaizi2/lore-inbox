Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293184AbSCUQQJ>; Thu, 21 Mar 2002 11:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310249AbSCUQQA>; Thu, 21 Mar 2002 11:16:00 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4224 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S293184AbSCUQPy>; Thu, 21 Mar 2002 11:15:54 -0500
Date: Thu, 21 Mar 2002 11:16:04 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: remount file-system mount change?
Message-ID: <Pine.LNX.3.95.1020321110453.349A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Any `mountd` gurus,

This kind of entry in /etc/exports used to let anybody in
the world read/write/delete from the file-system identified.

#/etc/exports
/scratch	*(rw,no_root_squash)

I don't know when it stopped working, but now I have to put in
individual host-names to allow access.

Is this part of some new 'security' thing or is it a bug? If it's
part of some new security thing, how do I reasonably enter the
IP addresses of a few hundred unknown lap-tops and other dynamic
systems?

If it's a bug, some more information is that from host 'foo' it is
no longer possible to do:

	mount foo:/scratch /mnt

...regardless of whatever is in /etc/exports, including 'localhost'
or specific IP addresses. I can't network-mount a host onto itself
anymore. This was useful to see what a remote-host would encounter
with, for instance, sym-links.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

