Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316963AbSFFN1P>; Thu, 6 Jun 2002 09:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316964AbSFFN1O>; Thu, 6 Jun 2002 09:27:14 -0400
Received: from pD9E23FC2.dip.t-dialin.net ([217.226.63.194]:10369 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316963AbSFFN1N>; Thu, 6 Jun 2002 09:27:13 -0400
Date: Thu, 6 Jun 2002 07:27:03 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Eric Kristopher Sandall <sandalle@wsunix.wsu.edu>
cc: Michael Zhu <mylinuxk@yahoo.ca>, John Tyner <jtyner@cs.ucr.edu>,
        <kernelnewbies@nl.linux.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Load kernel module automatically
In-Reply-To: <Pine.OSF.4.10.10206051320110.304-100000@unicorn.it.wsu.edu>
Message-ID: <Pine.LNX.4.44.0206060725430.3833-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 5 Jun 2002, Eric Kristopher Sandall wrote:
> in /etc/modules.conf (this is from memory, might not be exact)
> alias  eth0   3c59x
> alias  sound  sb
> options  sb  irq=7, io=0x220, dma=0, dma16=5

Erm, no. You can alias sb as sound, but this won't help you that much. It 
needs to be char-major-14, and for alsa sound-slot-0 (in addition!).

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

