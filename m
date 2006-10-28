Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751805AbWJ1Iez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbWJ1Iez (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 04:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbWJ1Iez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 04:34:55 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:58770 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751805AbWJ1Iey
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 04:34:54 -0400
Message-ID: <4543162B.7030701@drzeus.cx>
Date: Sat, 28 Oct 2006 10:34:51 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Christoph Hellwig <hch@lst.de>, Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>, Dominik Brodowski <linux@brodo.de>,
       Harald Welte <laforge@netfilter.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: feature-removal-schedule obsoletes
References: <45324658.1000203@gmail.com> <20061016133352.GA23391@lst.de> <200610242124.49911.arnd@arndb.de>
In-Reply-To: <200610242124.49911.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Monday 16 October 2006 15:33, Christoph Hellwig wrote:
>> On Sun, Oct 15, 2006 at 04:31:29PM +0159, Jiri Slaby wrote:
>>> What:   remove EXPORT_SYMBOL(kernel_thread)
>>> When:   August 2006
>>> Who:    Christoph Hellwig <hch@lst.de>
>> There are a lot of modular users left.  It'll go away as soon as these
>> users have disappeared.
> 
> It seems that most of the users that are left are for pretty obscure
> functionality, so I wouldn't expect that to happen so soon. Maybe we
> should mark it as __deprecated in the declaration?
> 

What should be used to replace it? The MMC block driver uses it to
manage the block device queue. I am not that intimate with the block
layer so I do not know the proper fix.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
