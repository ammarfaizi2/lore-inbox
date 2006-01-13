Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWAMEi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWAMEi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 23:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWAMEi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 23:38:56 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:3270 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751393AbWAMEiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 23:38:55 -0500
Date: Thu, 12 Jan 2006 22:37:39 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: machine check errors
In-reply-to: <5ukd5-3kf-17@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43C72E93.1030602@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5ukd5-3kf-17@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

don fisher wrote:
> I have a Tyan S2892 board with a pair Opteron 288 dual core cpus and 
> 16GB dram. I receive the errors shown in the attached file, mcelog. It 
> appears that these occur when the free memory becomes small, there is a 
> lot in the cache, and a lot of IO.
> 
> The Tyan S2892 has an Nvidia Crush K8-04, which I think they call the 
> southbridge. My errors appear to be related to the north bridge. There 
> is an AMD 8131 PCI-X controller that runs the PCI slots. There is a 
> 3WARE 9500-12 located in one of the PCI-X slots.
> 
> I have run Memtest86+-1.65 for 24 hours without errors. I recently 
> upgraded the BIOS to V2.00 without any remarkable changes.
> 
> I am running 2.6.15 within a current Fedora Core4 configuration.
> 
> I would appreciate any advice as to how to proceed. I have not noticed 
> any adverse behavior from the mce's. But that could be masked is data 
> transfered or ???.
> 
> Could there be any connection with the memory cache? Thanks in advance 
> for your assistance.

I would say you likely do have some bad RAM, that seems to be what those 
MCEs are indicating. Depending on the configuration, Memtest86 may not 
find all the errors if they are being corrected by ECC..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

