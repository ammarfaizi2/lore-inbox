Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWAOUv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWAOUv2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWAOUv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:51:28 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:15765 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750808AbWAOUvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:51:21 -0500
Date: Sun, 15 Jan 2006 21:51:19 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andi Kleen <ak@suse.de>
cc: 7eggert@gmx.de, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Console debugging wishlist was: Re: oops pauser.
In-Reply-To: <200601151813.26688.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0601152150440.4240@yvahk01.tjqt.qr>
References: <5rvok-5Sr-1@gated-at.bofh.it> <5tagc-6AZ-25@gated-at.bofh.it>
 <E1EyB3r-0000vP-G3@be1.lrz> <200601151813.26688.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > (it is hard to understand that with 128MB+ graphic cards and 512+MB
>> > computers the scroll back must be still so short...)
>> 
>> The VGA scrollback buffer is limited by the text area of the video RAM.
>> The text area is in the DOS memory at 0xB800 (or 0xB000) and extends
>> 32 KB (or in case of MDA, 4 KB). Each character will use 2 Bytes.
>> Therefore you can store up to 16,000 characters or 4 pages of text.
>
>It was a rhetorical question.
>
And I assumed that scrollback was stored in some regular kmalloc()ed page(s).


Jan Engelhardt
-- 
