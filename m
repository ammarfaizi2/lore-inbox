Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281201AbRKEQEe>; Mon, 5 Nov 2001 11:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281200AbRKEQEY>; Mon, 5 Nov 2001 11:04:24 -0500
Received: from mail016.mail.bellsouth.net ([205.152.58.36]:23860 "EHLO
	imf16bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281202AbRKEQEE>; Mon, 5 Nov 2001 11:04:04 -0500
Message-ID: <3BE6B869.D79E93B1@mandrakesoft.com>
Date: Mon, 05 Nov 2001 11:03:53 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: stephane@tuxfinder.org
CC: Massimo Dal Zotto <dz@debian.org>, LKLM <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMM BIOS on Dell i8100
In-Reply-To: <20011105100346.A1511@emeraude.kwisatz.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Jourdois wrote:
> 
> Hello,
> 
> First, a very big thanx to Massimo for this great piece of code :-)
> I've been trying to catch those events with no sucess for weeks.
> 
> I've got a Dell Inspiron 8100, which seems to differ slightly from
> i8000. Here is a patch that fixes that. Please do not hesitate to ask me
> to test some new code or anything on my laptop.
> 
> You should also replace your printk("string") with printk(KERN_INFO "string")

Has this been tested in I8000?  You are changing a lot of magic numbers
in the code, and noone but you/Massimo know whether that is ok or not...

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

