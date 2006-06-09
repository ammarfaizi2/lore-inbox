Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWFIKpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWFIKpO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 06:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWFIKpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 06:45:14 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:20420 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932211AbWFIKpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 06:45:13 -0400
Date: Fri, 9 Jun 2006 12:45:09 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sash <Sash_lkl@linuxhowtos.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Idea about a disc backed ram filesystem
In-Reply-To: <200606082312.02494.Sash_lkl@linuxhowtos.org>
Message-ID: <Pine.LNX.4.61.0606091138410.13744@yvahk01.tjqt.qr>
References: <200606082233.13720.Sash_lkl@linuxhowtos.org>
 <20060608204306.GA560@csclub.uwaterloo.ca> <200606082312.02494.Sash_lkl@linuxhowtos.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I am a bit puzzled.  How is your idea different in use than the current
>> caching system that the kernel already applies to reads of all block
>>...
>
>The idea was simply born to have a fast tmpfs but with the safety of permanent
>data storage in case of reboots/crashes without user level app modification.
>

When do you want to write to disk?
Anytime? That would impact on the "fast" attribute, in which case
you don't need ramfs.
Not anytime? Potential loss of data.
Hm.


Jan Engelhardt
-- 
