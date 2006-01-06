Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWAFFjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWAFFjR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 00:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWAFFjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 00:39:17 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:55476 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932366AbWAFFjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 00:39:17 -0500
Date: Thu, 05 Jan 2006 23:39:07 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: State of the Union: Wireless
In-reply-to: <5rRp0-4X1-3@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43BE027B.4010806@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5rRp0-4X1-3@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> * Release early, release often.  Pushing from an external repository to
>   the official kernel tree every few months creates more problems
>   than it solves.  Out-of-tree drivers fail to take advantage of
>   recent kernel changes and coding practices, which leads to bugs and
>   incompatibilities.  Slow pushing leads to huge periodic updates,
>   which are awful for debugging, testing, and general use.

I think this is an especially big problem, from a user's perspective at 
least.. I'm tired of patching up my laptop kernel with the latest 
ieee80211 and ipw2200 on every update because the mainline kernel 
contains an ancient version which is almost useless to me, and the Intel 
guys apparently don't feel like merging newer versions upstream until 
they get it perfect, or something..

I'm sure this would make it easier for other driver developers to work 
with the ieee80211 stack as well, if the current version wasn't 
maintained entirely out of tree for all intents and purposes..

The other complaint I have is that there's just too much breakage 
happening.. you update the wireless driver, then you have to update the 
wireless tools, then maybe WPA Supplicant stops working, etc. etc.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

