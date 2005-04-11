Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVDKCjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVDKCjf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 22:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVDKCjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 22:39:35 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:52955 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261666AbVDKCjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 22:39:31 -0400
Date: Sun, 10 Apr 2005 20:39:06 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: easy softball jiffies quest(ion)
In-reply-to: <3Rgon-7E2-3@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4259E34A.6050109@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3Rgon-7E2-3@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

philip dahlquist wrote:
> hi,
> 
> i'm on a quest to get access to jiffies in user space so i can write a
> simple stepper motor driver program.  i co-opted the "#includes" list 
> from alessandro rubini's jit.c file from "linux device drivers" to write
> jfi.c.

That's not going to work, jiffies is an internal kernel value, you can't 
access it from userspace. What do you need jiffies for to do this?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


