Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269072AbUJKRL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269072AbUJKRL6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 13:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269038AbUJKRKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 13:10:51 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:25241 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S269065AbUJKRJF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 13:09:05 -0400
Message-ID: <416ABE31.3040004@ens-lyon.fr>
Date: Mon, 11 Oct 2004 19:09:05 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: suspend-to-RAM [was Re: Totally broken PCI PM calls]
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org> <16746.299.189583.506818@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410102102140.3897@ppc970.osdl.org> <16746.2820.352047.970214@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410110739150.3897@ppc970.osdl.org> <20041011145628.GA2672@elf.ucw.cz> <416AAC5F.7020109@ens-lyon.fr> <20041011161718.GA1045@elf.ucw.cz>
In-Reply-To: <20041011161718.GA1045@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>On my N600c, suspend-to-RAM seems to complete... but when I try to wake 
>>up the laptop (by pressing the power button), it blinks strangely and 
>>then immediately shutdowns instead of resuming...
> 
> 
> Your machine is probabl different from N620c i this regard...
> 
> Can you test if it reaches start of wakeup.S? Just insert infinite
> loop there...
> 								Pavel

Well, my apologies, the behavior changed recently:
* S1 seems to work.
* S3 is so buggy: suspend still seem to complete. Pushing the power 
button to resume doesn't shutdown the machine anymore: the laptop wakes 
up but doesn't write or do anything. I'm only able to stop it by 
pressing the power button.

Regards,
Brice Goglin

