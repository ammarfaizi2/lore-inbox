Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbTA1Ntk>; Tue, 28 Jan 2003 08:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbTA1Ntk>; Tue, 28 Jan 2003 08:49:40 -0500
Received: from webmail7.rediffmail.com ([202.54.124.152]:2692 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id <S265470AbTA1Ntj>;
	Tue, 28 Jan 2003 08:49:39 -0500
Date: 28 Jan 2003 14:06:11 -0000
Message-ID: <20030128140611.31677.qmail@webmail7.rediffmail.com>
MIME-Version: 1.0
From: "nitin  kumbhar" <nkumbhar@rediffmail.com>
Reply-To: "nitin  kumbhar" <nkumbhar@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: driver address space
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 	I have a small query about kernel image organization. i am 
using
2.4.7 kernel version.Is there any data structure in kernel which 
will give
information about _all_ kernel symbols? i could get the data 
structure
which gives _exported_ symbols only. But not all symbols. Using 
this
structure i want to access information about functions present in 
a driver,
which can be used to find out address range(_start_address_ &
_end_address_) of the driver in kernel address space.
 	It is possible to get this information about functions in a 
driver
using System.map. to get this information into kernel can we push 
the
content of this file into kernel image? i think this can be done 
either by
putting it at specific address or appending the image. Will it be 
OK to
access System.map(all kernel symbols) in this way from kernel? 
Could
this cause any security or some other problems?
 	Or apart from this is there any other way to find out driver's
address range in the kernel?

 	I hope this not something totally out of context. Thank You.

Regards,
Nitin



