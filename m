Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbTKTWt6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 17:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbTKTWt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 17:49:58 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:22954 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262901AbTKTWt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 17:49:56 -0500
Date: Thu, 20 Nov 2003 14:48:44 -0800
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>
cc: hannal@us.ibm.com, Martin Schlemmer <azarah@nosferatu.za.org>,
       Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: driver model for inputs
Message-ID: <55080000.1069368524@w-hlinder>
In-Reply-To: <20031120222825.GE196@elf.ucw.cz>
References: <20031119213237.GA16828@fs.tum.de> <20031119221456.GB22090@kroah.com> <1069283566.5032.21.camel@nosferatu.lan> <20031119232651.GA22676@kroah.com> <20031120125228.GC432@openzaurus.ucw.cz> <20031120170303.GJ26720@kroah.com>
 <20031120222825.GE196@elf.ucw.cz>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, November 20, 2003 11:28:25 PM +0100 Pavel Machek <pavel@ucw.cz> wrote:


>> tree.  Hanna Linder is working on the input sysfs patches, and has
>> posted some work in the past.
> 
> I could only find 2.5.70 patches, and those did not seem "good enough"
> to do power managment with them. Do you have some newer version?
> 
> [One of machines near me needs keyboard to be reinitialized after S3
> sleep... And users are starting to hit that, too.]
> 								Pavel

Hi Pavel,

I have test8 version of the patch which mostly works. The only problem now
is a panic when I remove the mouse... The input layer is sorta hard to follow
you know :) Im guessing it is a reference counting issue. Do you want what I
have now or can I update it to test9 and see if taking a break from staring
at it has helped?

Thanks.

Hanna

