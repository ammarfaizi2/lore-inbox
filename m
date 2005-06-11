Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVFKGp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVFKGp3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 02:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVFKGp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 02:45:29 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:33347 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261619AbVFKGpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 02:45:21 -0400
Message-ID: <42AA8882.40109@m1k.net>
Date: Sat, 11 Jun 2005 02:45:22 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bttv synchronizing patch
References: <42A9CE83.807@brturbo.com.br> <20050610175438.1553349d.akpm@osdl.org>
In-Reply-To: <20050610175438.1553349d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Mauro Carvalho Chehab <mchehab@brturbo.com.br> wrote:
>  
>
>>    It is asked that *every* patch to V4L stuff to be first submitted to
>> video4linux-list@redhat.com.
>>    
>>
>In that case you might want to double-check the patches which I have queued
>for post-2.6.12:
>
>fix-for-cx88-cardsc-for-dvico-fusionhdtv-3-gold-q.patch
>bttv-support-for-adlink-rtv24-capture-card.patch
>bttv-support-for-adlink-rtv24-capture-card-tidy.patch
>bttv-support-for-adlink-rtv24-capture-card-more-tidy.patch
>v4l-saa7134-ntsc-vbi-fix.patch
>v4l-pal-m-chroma-subcarrier-frequency-fix.patch
>video-for-linux-docummentation.patch
>v4l-add-support-for-pixelview-ultra-pro.patch
>dvico-fusionhdtv3-gold-t-documentation-fix.patch
>v4l-support-tuner-thomson-ddt-7611-atsc-ntsc.patch
>  
>
The following three patches are from me:

fix-for-cx88-cardsc-for-dvico-fusionhdtv-3-gold-q.patch
dvico-fusionhdtv3-gold-t-documentation-fix.patch
v4l-support-tuner-thomson-ddt-7611-atsc-ntsc.patch

...and they depend on the following two patches submitted by Mauro:

video-for-linux-docummentation.patch
v4l-add-support-for-pixelview-ultra-pro.patch

...When these patches are applied in the order listed in Andrew's email, the result is the same as what I currently have in v4l cvs.

-- 
Michael Krufky

