Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVJOG32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVJOG32 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 02:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVJOG32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 02:29:28 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:51497 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751092AbVJOG31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 02:29:27 -0400
Date: Sat, 15 Oct 2005 00:29:25 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Anybody know about nforce4 SATA II hot swapping + linux raid?
In-reply-to: <4XMt3-7Yt-5@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4350A1C5.3080902@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4UXuH-EU-31@gated-at.bofh.it> <4XLQk-6Z2-1@gated-at.bofh.it>
 <4XMt3-7Yt-5@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lajber Zoltan wrote:
> We have about 7 serverraid card from 4L to 5i. All of them is sitting on
> shelf. They are pain to manage, ipssend tool is weak, serverdirector
> complicated. And they are slow, the Fusion MPT SCSI with sw raid
> significant faster, as we measured with bonnie++. Even the old aic7892 is
> faster (these built-in scsi controllers on xseries motherboards).

The 6i and 7 series of cards seem to have quite a bit better relative 
speeds. Certainly the 4Lx cards can be outperformed in simple "hdparm" 
tests by a 3ware SATA controller/disks of half the price..

Plus, software RAID can't provide good performance on many server/DB 
applications without risking data loss in certain cases - for such 
things one really wants something with a battery-backed cache on it..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

