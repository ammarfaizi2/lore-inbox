Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273037AbRIOU3v>; Sat, 15 Sep 2001 16:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273031AbRIOU3l>; Sat, 15 Sep 2001 16:29:41 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:29452 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273027AbRIOU32>; Sat, 15 Sep 2001 16:29:28 -0400
Subject: Re: [PATCH] AGP GART for AMD 761
From: Robert Love <rml@tech9.net>
To: Jesper Juhl <juhl@eisenstein.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BA23224.C105A0A6@eisenstein.dk>
In-Reply-To: <1000577021.32706.29.camel@phantasy> 
	<3BA22537.94D4EA28@eisenstein.dk> <1000582067.32708.51.camel@phantasy> 
	<3BA228EA.FCD61CA1@eisenstein.dk> <1000583357.32707.54.camel@phantasy> 
	<3BA23224.C105A0A6@eisenstein.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.14.18.39 (Preview Release)
Date: 15 Sep 2001 16:30:24 -0400
Message-Id: <1000585830.32705.59.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-09-14 at 12:36, Jesper Juhl wrote:
> Seems to work much better :
> 
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 439M
> agpgart: Detected AMD 761 chipset
> agpgart: AGP aperture is 64M @ 0xf8000000

Excellent.  Thank you for testing -- I don't even have a 761 :)
 
> Actually the previous patch may have worked as well, while trying to figure out why I couldn't
> get it to apply I was playing around with the configuration and various other stuff and I may
> accidentaly have disabled Irongate support in the kernel that I ended up building. I can retry
> the original patch to verify that if you like.

Actually, test out the final patch I submit to the list and Linus and
Alan, and make sure _that_ works (I will disable the agp_try_unsupported
there).  Let me know if that gives you problems...I will post it in a
moment.

Thanks again for your help, hope the driver works good

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net


