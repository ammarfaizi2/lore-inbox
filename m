Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTHUMev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 08:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbTHUMev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 08:34:51 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:11253 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262652AbTHUMeu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 08:34:50 -0400
Message-ID: <3F44BC9F.7030606@softhome.net>
Date: Thu, 21 Aug 2003 14:35:43 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usb-storage: how to ruin your hardware(?)
References: <mMAP.NQ.15@gated-at.bofh.it> <mMUh.12N.19@gated-at.bofh.it> <mUI5.7Hp.27@gated-at.bofh.it>
In-Reply-To: <mUI5.7Hp.27@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak wrote:
> 
> Maybe a message of caution should be displayed in usb-storage
> configure help about attemtping to change partitions and/or filesystems on
> USB storage devices.
> 

   The stuff I have met with CompactFlash cards (*without* USB) - they 
by default were coming formated with single FAT12 partition - no 
partition table whatsoever.
   I had no problems with partitioning and formating (in IDE emulation 
mode).

   But Windoz2kOfBugs was refusing to work with flashes which had 
partition table, and was working Okay with /original/ FAT12 formated 
flashes. Windoz wasn't even trying to read partition table, always 
showing flash as one drive - and sure it was reporting stupid errors 
when you were trying to do something with partitioned flash.

   It looks like /agreement/ (with The Beast) that flashe/memory card 
has to have FAT12.

   No comments.

