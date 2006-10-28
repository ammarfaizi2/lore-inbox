Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752060AbWJ1KHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbWJ1KHH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 06:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbWJ1KHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 06:07:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:15595 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1752060AbWJ1KHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 06:07:04 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: feature-removal-schedule obsoletes
Date: Sat, 28 Oct 2006 12:06:54 +0200
User-Agent: KMail/1.9.5
Cc: Christoph Hellwig <hch@lst.de>, Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>, Dominik Brodowski <linux@brodo.de>,
       Harald Welte <laforge@netfilter.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jean Delvare <khali@linux-fr.org>
References: <45324658.1000203@gmail.com> <200610242124.49911.arnd@arndb.de> <4543162B.7030701@drzeus.cx>
In-Reply-To: <4543162B.7030701@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610281206.54940.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 October 2006 10:34, Pierre Ossman wrote:
> 
> What should be used to replace it? The MMC block driver uses it to
> manage the block device queue. I am not that intimate with the block
> layer so I do not know the proper fix.
> 
You should use kthread_create().

	Arnd <><
