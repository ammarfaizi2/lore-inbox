Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292539AbSBTWKs>; Wed, 20 Feb 2002 17:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292540AbSBTWKf>; Wed, 20 Feb 2002 17:10:35 -0500
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:29364 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S292539AbSBTWKQ>;
	Wed, 20 Feb 2002 17:10:16 -0500
Date: Wed, 20 Feb 2002 22:08:44 GMT
Message-Id: <200202202208.g1KM8if07634@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2 (FIXED ALMOST)
In-Reply-To: <20020220151053.A1198@vger.timpanogas.org>
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-21 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020220151053.A1198@vger.timpanogas.org> you wrote:

> unsigned long + unsigned long)  Last time I checked, unsigned long
> was a construct for a 32 bit value in any gcc compiler version, ia64 
> or not.

16 bit msdos mode doesn't count; otherwise it really is 64 bit on 64 bit
machines.... as per ansi C definition: unsigned long is big enough to
hold a data pointer....
