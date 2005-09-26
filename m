Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbVIZDvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVIZDvF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 23:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbVIZDvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 23:51:04 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:19636 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932363AbVIZDvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 23:51:03 -0400
Date: Sun, 25 Sep 2005 21:49:37 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Strange behaviour with SATA disks. Light always ON
In-reply-to: <4QP2K-4ML-7@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43376FD1.2020306@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-15
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4QP2K-4ML-7@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo da Silva wrote:
> Hi!
> I don't know if this is the right place to ask
> about this, or even if this is a problem at all.
> 
> Anyway I didn't find relevant information on
> this ...
> 
> I have just bought a new PC with two SATA drives.
> I had no problems to have them working,
> apparently fine except for one thing:
> After reading the kernel, the driver access light (led?)
> is always on!
> Is this normal? Why?

I don't know if this is considered "normal" but I know that the Silicon 
Image chips do have a strange way of handling the access light - it has 
to be specifically turned on and off by a GPIO pin in the driver, the 
chip doesn't seem to handle it itself..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

