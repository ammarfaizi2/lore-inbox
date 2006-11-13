Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755046AbWKMPPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046AbWKMPPX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755124AbWKMPPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:15:23 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:45717 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1755046AbWKMPPV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:15:21 -0500
Message-ID: <45588C0F.60002@drzeus.cx>
Date: Mon, 13 Nov 2006 16:15:27 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>, Dominik Brodowski <linux@brodo.de>,
       Harald Welte <laforge@netfilter.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: feature-removal-schedule obsoletes
References: <45324658.1000203@gmail.com> <20061016133352.GA23391@lst.de> <200610242124.49911.arnd@arndb.de> <4543162B.7030701@drzeus.cx> <20061028105755.GA20103@lst.de>
In-Reply-To: <20061028105755.GA20103@lst.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sat, Oct 28, 2006 at 10:34:51AM +0200, Pierre Ossman wrote:
>   
>> What should be used to replace it? The MMC block driver uses it to
>> manage the block device queue. I am not that intimate with the block
>> layer so I do not know the proper fix.
>>     
>
> kthread_create/kthread_run.  Here's a draft patch (and it's against
> a rather old tree and untested due to lack of hardware so it really
> should be considered just a draft).
>
>   

Patch looks ok to me and seems to work fine. Are you willing to sign off
on it?

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

