Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317166AbSFBLhQ>; Sun, 2 Jun 2002 07:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSFBLhP>; Sun, 2 Jun 2002 07:37:15 -0400
Received: from pD9E239B5.dip.t-dialin.net ([217.226.57.181]:55200 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317166AbSFBLhO>; Sun, 2 Jun 2002 07:37:14 -0400
Date: Sun, 2 Jun 2002 05:37:11 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Peter Osterlund <petero2@telia.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: KBuild 2.5 Impressions
In-Reply-To: <m2hekmgc4i.fsf@ppro.localdomain>
Message-ID: <Pine.LNX.4.44.0206020534461.29405-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2 Jun 2002, Peter Osterlund wrote:
> 3. You have to remember the "-f Makefile-2.5" arguments to make,
>    otherwise it will use the old makefile system. This seems to mess
>    things up so that subsequent make commands fail.
>    I tried to "mv Makefile-2.5 Makefile" to overcome this problem, but
>    it doesn't work because the original Makefile appears to be needed
>    for extracting kernel version information.

There was no intention to reinvent the wheel. The only _replacing_ 
Makefile is a _merged_ version of them. Then you'll also have to find any 
Makefile-2.5s and revert them to Makefiles. This will take a moment, and 
is not yet intented.

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

