Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274373AbRITIwV>; Thu, 20 Sep 2001 04:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274374AbRITIwL>; Thu, 20 Sep 2001 04:52:11 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:41999 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S274373AbRITIwC>;
	Thu, 20 Sep 2001 04:52:02 -0400
To: rgooch@ras.ucalgary.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: drivers/char/sonypi.h broken
In-Reply-To: <200109200401.f8K413n29745@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200109200401.f8K413n29745@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E15jzZF-0003Qc-00@come.alcove-fr>
From: Stelian Pop <stelian@alcove.fr>
Date: Thu, 20 Sep 2001 10:52:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In alcove.lists.linux.kernel, you wrote:

>   Hi, Linus. I now find that drivers/char/sonypi.h has been broken in
> 2.4.10-pre12. I get the following compile errors:
> 
> sonypi.h:195: `SONYPI_EVENT_PKEY_P1' undeclared here (not in a function)
[...]

Already submitted a patch for this here and cc:'ed to Linus. 
See: http://www.uwsg.indiana.edu/hypermail/linux/kernel/0109.2/0617.html

> Hopefully the guilty party (i.e. the lazy bastard who sent in a
> broken patch without bothering to compile the fucking thing first)
> will be shamed into generating a patch ASAP.

Calm down. The lazy bastard here is either Linus or Alan. This driver
update is a merge from the -ac tree, where this driver remained 
unmodified for several weeks now.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
