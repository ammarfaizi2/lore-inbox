Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268582AbRHSRxW>; Sun, 19 Aug 2001 13:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268598AbRHSRxM>; Sun, 19 Aug 2001 13:53:12 -0400
Received: from mail.mesatop.com ([208.164.122.9]:26125 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S268582AbRHSRw7>;
	Sun, 19 Aug 2001 13:52:59 -0400
Message-Id: <200108191753.f7JHr8e27206@thor.mesatop.com>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Luigi Genoni <kernel@Expansa.sns.it>, "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Swap size for a machine with 2GB of memory
Date: Sun, 19 Aug 2001 11:52:50 -0400
X-Mailer: KMail [version 1.2.3]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, <gars@lanm-pc.com>
In-Reply-To: <Pine.LNX.4.33.0108191916350.5840-100000@Expansa.sns.it>
In-Reply-To: <Pine.LNX.4.33.0108191916350.5840-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 August 2001 01:29 pm, Luigi Genoni wrote:
[snipped]
> On my ultrasparc linux with 4 GByte of RAM running 2.4.X kernels,
> I needed to add a 8 GB disk just for
> swap (16 partitions of 512 MB each one).
--------^^
Just curious, in linux-2.4.9/include/linux/swap.h line 11, we have:

#define MAX_SWAPFILES 8

Did you change this to 16, or does this not matter anymore?  
This value is the same in 2.4.8-ac7.

Steven
