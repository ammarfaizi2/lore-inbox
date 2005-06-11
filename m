Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVFKQD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVFKQD0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 12:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVFKQDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 12:03:25 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:10973 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261602AbVFKQDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 12:03:22 -0400
Date: Sat, 11 Jun 2005 10:02:38 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: amd64 cdrom access locks system
In-reply-to: <4dJWr-38Z-33@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42AB0B1E.5070806@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4d3Xi-33s-31@gated-at.bofh.it> <4d7Rk-6fq-49@gated-at.bofh.it>
 <4dE0F-77V-17@gated-at.bofh.it> <4dEk0-7ua-1@gated-at.bofh.it>
 <4dJWr-38Z-33@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Wiegley wrote:
>    cdrecord -v -eject -dao dev=ATAPI:/dev/hda something.iso
> cdrecord comes up and spits out:
> ...
>   Warning: Using ATA Packet interface.
>   Warning: The related Linux kernel interface code seems to be 
> unmaintained.
>   Warning: There is absolutely NO DMA, operations thus are slow.

I don't think this is the interface option you want to be using - try 
just dev=/dev/hda. I don't know if this is why you were getting errors 
though.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

