Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130079AbRBZApZ>; Sun, 25 Feb 2001 19:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130078AbRBZApF>; Sun, 25 Feb 2001 19:45:05 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:14021 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S130072AbRBZApB>; Sun, 25 Feb 2001 19:45:01 -0500
Message-Id: <l03130306b6bf522b1087@[192.168.239.101]>
In-Reply-To: <3A9999FD.AEFC4570@coplanar.net>
In-Reply-To: <20010214092251.D1144@e-trend.de>
 <3A8AA725.7446DEA0@ubishops.ca> <20010214165758.L28359@e-trend.de>
 <20010214122244.H7859@conectiva.com.br> <3A99986F.1AC6A46F@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 26 Feb 2001 00:24:20 +0000
To: Jeremy Jackson <jerj@coplanar.net>, linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Should isa-pnp utilize the PnP BIOS?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Would it not be useful if the isa-pnp driver would fall back
>> to utilizing the PnP BIOS (if possible) in order to read and
>
>I would find this EXTREMELY usefull... my Compaq laptop's
>hot-dock with power eject will only work if Linux uses
>PnP BIOS's insert/eject methods.
>
>I saw some code in early 2.3 that would talk to bios, i still have
>a tarball, but it seems 2.4 only does hardware banging (best in
>*most* cases...)

There are some desktop m/boards that don't seem to respond to the
kernel-mode ISA-PnP at the moment, too.  Particularly my Abit KT7 - I have
to use user-mode ISA-PnP for it to pick up my nice SB AWE-64.  This needs
fixing somehow, and maybe looking at the PnP BIOS stuff is the right way.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


