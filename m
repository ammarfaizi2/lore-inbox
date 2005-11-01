Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbVKAEGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbVKAEGr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 23:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbVKAEGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 23:06:47 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:41679 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S965012AbVKAEGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 23:06:46 -0500
Date: Mon, 31 Oct 2005 22:05:49 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: echo 0 > /proc/sys/vm/swappiness triggers OOM killer under 2.6.14.
In-reply-to: <53vpu-s9-17@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4366E99D.7070606@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <53vpu-s9-17@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> Under 2.6.14 (UML), I have a workload that runs with 64 megs ram and 256 megs 
> swap space.  It completes (albeit swapping like mad) with swappiness at the 
> default 60, but if I set it to 0 the OOM killer kicks in and the script 
> aborts.

You should get some debugging output in dmesg when the OOM killer kicks 
in, can you post this?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

