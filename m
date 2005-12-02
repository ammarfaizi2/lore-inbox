Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932718AbVLBBmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbVLBBmq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 20:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932714AbVLBBmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 20:42:46 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:21033 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932720AbVLBBmp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 20:42:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mICdiqMUO+rkTD6nGN7pDIsPLjh8LF+6L1lS4LyF4fCVFGaReJQn6pSroXR+YbY0Z4jAaXsfpzcTup6sZNIJGpSxqlMpzCRZ/AaBbNkTQhQqmrUzwapXRDm9M682LL1/ciFiMmCRXiyrWNARQgWc5+KAgU5fupxRG2CWRZX648k=
Message-ID: <a762e240512011742p681df3bdic16598a85926dd67@mail.gmail.com>
Date: Thu, 1 Dec 2005 17:42:43 -0800
From: Keith Mannthey <kmannth@gmail.com>
To: Bharath Ramesh <krosswindz@gmail.com>
Subject: Re: Only one processor detected in 8-Way opteron in 32-bit mode
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <c775eb9b0512011712x2f4f2f44t4cd11d5d6f60a9d8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c775eb9b0512011315y40bdbf30w172583cd85e92fa6@mail.gmail.com>
	 <a762e240512011527s69053b8eg13ec4674c3e36b07@mail.gmail.com>
	 <c775eb9b0512011651kb0e1cb4xf79ca20372f6d76e@mail.gmail.com>
	 <c775eb9b0512011712x2f4f2f44t4cd11d5d6f60a9d8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did the smp kernel that came with your distro boot smp on i386?

An apic is an apic.  I don't think there is a diffrent interrupt
controler (but maybe I am wrong)  I can boot opteron SMP with i386
just fine.  My guess is what you are seeing is specific to your box.
What sort of a box is this 8-way AMD Opteron.....

What i386 subarch are you selecting in your i386 build?  Could you try
the Generic architecture?  Maybe the box is in clustered apic mode.

Does booting with acpi=off help?

Can you send the dmesg from your x86_64 partition.   It will show us
what the apic is doing in that arch.

Thanks,
 Keith
