Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129740AbRCHWWk>; Thu, 8 Mar 2001 17:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130008AbRCHWWb>; Thu, 8 Mar 2001 17:22:31 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:59300 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S129740AbRCHWWW>; Thu, 8 Mar 2001 17:22:22 -0500
Message-Id: <l03130320b6cdb5274fac@[192.168.239.101]>
In-Reply-To: <3AA80004.65259634@voicenet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 8 Mar 2001 22:21:41 +0000
To: safemode <safemode@voicenet.com>, linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: incorrect CPU usage readings in 2.2.19prex?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

\>Is there something generally wrong with how linux determines total cpu
>usage (via procmeter3 and top) when dealing with applications that are
>threaded?   I routinely get 0% cpu usage when playing mpegs and mp3s and
>some avi's even (Divx when using no software enhancement) ... Somehow i
>doubt that the decoders are so streamlined that they produce <1% cpu
>usage on the computer.  Does anyone know what's going on with this?
>ps shows nearly 0% cpu usage in the threads as well.

If you're using a fairly new processor, this isn't at all new or surprising
- and yes, your MP3 decoders are really using under 1% CPU.  In general,
most processors with on-die or 'backside' L2 cache are capable of this.
The reason why older CPUs cannot manage this (eg. 486's and very early
Pentiums) is mostly due to memory bandwidth and thrashing the tiny L1
caches found on those processors - the lack of speed of the 486 itself is
also a factor, but not the only one.  Remember that a 486DX2/66 is
just-about capable of real-time MP3 decoding, and that CPU power has
increased around 50-fold from that point to the present day, not counting
improvements in memory and cache technology.

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


