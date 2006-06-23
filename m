Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752095AbWFWVl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbWFWVl5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbWFWVl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:41:57 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:27571 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752095AbWFWVl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:41:57 -0400
Message-ID: <449C6023.9010204@garzik.org>
Date: Fri, 23 Jun 2006 17:41:55 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Hamish <hamish@travellingkiwi.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SATA hangs...
References: <200606232134.42231.hamish@travellingkiwi.com>
In-Reply-To: <200606232134.42231.hamish@travellingkiwi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hamish wrote:
> Hi.
> 
> I'm having problems with a SATA drive on an ASUS A8V deluxe 
> motherboard under kernel 2.6.17... In fact it's happened under 
> every (Vanilla) kernel I've ever run on this server (Back to 2.6.14).
> (It's just over a year old. It didn't used to experience the same load
> as it does now, so I'm currently assuming it's load related...
> 
> The box is a 3GB memory, Barton core AMD64 3200+, with a 30GB IDE (IDE0), 
> 160GB IDE (IDE1) and a 200GB SATA drive.
> 
> After anywhere between a few minutes (Rare) and several hundred hours 
> of uptime, access to filesystems on the SATA drive stop in mid flow 
> (Almost always under light  to heavy load. e.g. watching mythtv from
> a saved .mpg on a reiserfs filesystem on an LVM2 volume).
> 
> I've tried the SATA drive on two different SATA ports as well. ata0 & ata1.

Does -mm give you better behavior?

	Jeff



