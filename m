Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWBVOYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWBVOYk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 09:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWBVOYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 09:24:40 -0500
Received: from picard.linux.it ([213.254.12.146]:44492 "EHLO picard.linux.it")
	by vger.kernel.org with ESMTP id S1751291AbWBVOYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 09:24:39 -0500
Message-ID: <17679.217.33.203.18.1140618278.squirrel@picard.linux.it>
In-Reply-To: <20060221134323.6a5e5a95.akpm@osdl.org>
References: <20060220042615.5af1bddc.akpm@osdl.org>
    <20060221190031.GA3531@inferi.kami.home>
    <20060221134323.6a5e5a95.akpm@osdl.org>
Date: Wed, 22 Feb 2006 15:24:38 +0100 (CET)
Subject: Re: 2.6.16-rc4-mm1 console (radeonfb) not resumed after s2ram
From: "Mattia Dongili" <malattia@linux.it>
To: "Andrew Morton" <akpm@osdl.org>
Cc: "Mattia Dongili" <malattia@linux.it>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, February 21, 2006 10:43 pm, Andrew Morton said:
> Mattia Dongili <malattia@linux.it> wrote:
>>
>> On Mon, Feb 20, 2006 at 04:26:15AM -0800, Andrew Morton wrote:
>> >
>> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/
>>
>> After suspend the system is fully working except it doesn't resume the
>> console (I'm using radeonfb). If suspending from X the thing comes back,
>> X working ok, but switching to vt1 I see the console completely garbled.
>> Reverting radeonfb-resume-support-for-samsung-p35-laptops.patch (_wild_
>> guess) does not help.
>> Any good candidate?
>
> Did you apply the patches in the hot-fixes directory?
> revert-reset-pci-device-state-to-unknown-after-disabled.patch might help.

Sorry, this didn't help either. I'll try to revert some suspend related
patches then go bisecting if still unsuccessful.

-- 
mattia
:wq!


