Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269850AbUIDJcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269850AbUIDJcN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 05:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269852AbUIDJcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 05:32:13 -0400
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:32740 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S269850AbUIDJcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 05:32:05 -0400
Message-ID: <41398B93.40207@blueyonder.co.uk>
Date: Sat, 04 Sep 2004 10:32:03 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: NVIDIA Driver 1.0-6111 fix
References: <41390988.2010503@blueyonder.co.uk> <200409041125.21915.dominik.karall@gmx.net>
In-Reply-To: <200409041125.21915.dominik.karall@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Sep 2004 09:32:27.0930 (UTC) FILETIME=[17F06FA0:01C49262]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Karall wrote:

>On Saturday 04 September 2004 02:17, Sid Boyce wrote:
>  
>
>>The NVIDIA Linux Discussion forum has a patch that works with 2.6.9-rc1-mm3
>>http://gentoo.kems.net/gentoo-x86-portage/media-video/nvidia-kernel/files/1
>>.0.6111/nv_enable_pci.patch Regards
>>Sid.
>>    
>>
>
>this patch only fixes the "routeirq" problem, or? because i can't see any 
>changes for pci_find_class.
>
>regards,
>dominik
>  
>
Looking at nv.c, I had already changed all instances of pci_find_class 
to pci_get_class some time ago, so this patch is the other missing 
piece. I didn't have a problem until 2.6.9-rc1-mm2, but it seems other 
encountered it back at 2.6.8.1-rc1-mm2 and the patch appeared then on lkml.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====

