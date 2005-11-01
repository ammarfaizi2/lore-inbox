Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbVKAIzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbVKAIzm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbVKAIzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:55:42 -0500
Received: from [85.8.13.51] ([85.8.13.51]:15509 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S964879AbVKAIzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:55:41 -0500
Message-ID: <43672D74.1090106@drzeus.cx>
Date: Tue, 01 Nov 2005 09:55:16 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.4.1 (X11/20051008)
MIME-Version: 1.0
To: "Ian E. Morgan" <imorgan@webcon.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: TI FlashMedia driver
References: <Pine.LNX.4.64.0510311510130.8105@light.int.webcon.net>
In-Reply-To: <Pine.LNX.4.64.0510311510130.8105@light.int.webcon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian E. Morgan wrote:
> Given the number of people annoyed by the lack of a driver for TI's
> FlashMedia controller (part of the 6xx1 & 7xx1 series chips), myself one of
> them, I've started a project to reverse-engineer the device.
> 
> Basic details available here, adding new info whenever I get/discover it:
> http://www.webcon.ca/~imorgan/tifm21/
> 

There is some information about at least MMC controllers at:

http://mmc.drzeus.cx

The controller your working with is found here:

http://mmc.drzeus.cx/wiki/Controllers/TexasInstruments


 From your page:

> I was hoping the data block would reveal some basic information about the card that was inserted (capacity at least), but the above observations seem to deny that assumption.

All controllers I've seen so far either give raw access to the MMC bus 
or completely abstracts the MMC bits (making it a USB storage device or 
similar). In other words, you probably won't see any information other 
than the fact that a card has been inserted.

Rgds
Pierre
