Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbVLYVR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbVLYVR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 16:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbVLYVR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 16:17:28 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:10706 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750937AbVLYVR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 16:17:27 -0500
Date: Sun, 25 Dec 2005 22:17:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Axel Kittenberger <axel.kittenberger@univie.ac.at>
cc: Folkert van Heusden <folkert@vanheusden.com>, Marc Singer <elf@buici.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Possible Bootloader Optimization in inflate (get rid of     
 unnecessary 32k Window)
In-Reply-To: <1379.81.217.14.229.1135545026.squirrel@webmail.univie.ac.at>
Message-ID: <Pine.LNX.4.61.0512252215520.15152@yvahk01.tjqt.qr>
References: <200512221352.23393.axel.kernel@kittenberger.net>   
 <20051222173704.GB23411@buici.com>    <1167.81.217.14.229.1135275158.squirrel@webmail.univie.ac.at>
    <20051222183012.GA27353@buici.com>    <20051225210118.GB1498@vanheusden.com>
 <1379.81.217.14.229.1135545026.squirrel@webmail.univie.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> On the other hand it makes the kernel a few bytes smaller :-)
>
>Well on rather slow machines it is a bit faster indeed, I did code it 3
>years ago for an embedded system (embedded PowerPC). 'til now I just never
>found the time to offer a patch back to "vanilla" linux. I recently just
>thought I could ask maybe if it is after all desired even so....

Well if it's about size, why is not something better than gzip used yet?
Like bzip2, 7z or whatever comes to mind? Is it because of the amount of 
memory required for decompression?


Jan
