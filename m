Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWGKSEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWGKSEV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWGKSEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:04:21 -0400
Received: from terminus.zytor.com ([192.83.249.54]:16547 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751167AbWGKSEU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:04:20 -0400
Message-ID: <44B3E814.3060004@zytor.com>
Date: Tue, 11 Jul 2006 11:04:04 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: Jeff Garzik <jeff@garzik.org>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
References: <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru> <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com> <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org> <20060711171624.GA16554@suse.de> <44B3DEA0.3010106@zytor.com> <20060711173030.GA16693@suse.de> <44B3E40E.2090306@zytor.com> <20060711180126.GB16869@suse.de>
In-Reply-To: <20060711180126.GB16869@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
> But for the partition discovery (the ROOT_DEV users) its likely less than
> 100 lines of code. And after all, root= exists. Probably not a big loss if
> that code just disappears.

Partition discovery is not "the ROOT_DEV users".  It's the mapping of 
certain chunks of disk to partitions.

	-hpa
