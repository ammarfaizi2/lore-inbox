Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVETPYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVETPYd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 11:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVETPYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 11:24:33 -0400
Received: from alog0374.analogic.com ([208.224.222.150]:29162 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261450AbVETPYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 11:24:21 -0400
Date: Fri, 20 May 2005 11:24:06 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Marco Rogantini <marco.rogantini@supsi.ch>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Screen regen buffer at 0x00b8000
In-Reply-To: <Pine.LNX.4.62.0505201639170.14709@rost.dti.supsi.ch>
Message-ID: <Pine.LNX.4.61.0505201123140.5107@chaos.analogic.com>
References: <Pine.LNX.4.61.0505200944060.5921@chaos.analogic.com>
 <20050520141434.GZ2417@lug-owl.de> <Pine.LNX.4.62.0505201639170.14709@rost.dti.supsi.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2005, Marco Rogantini wrote:

> On Fri, 2005-05-20 09:48:35 -0400, Richard B. Johnson <linux-os@analogic.com> wrote:
>
>>     if((fd = open("/dev/mem", O_RDWR)) == FAIL)
>>         ERRORS("open");
>>     if((sp = mmap((void *)SCREEN, len, PROT, TYPE, fd, SCREEN))==MAP_FAILED)
>>         ERRORS("mmap");
>
> Try to open("/dev/mem", O_RDWR | O_SYNC). Without this the mapping
> will be chached.
>
> 	-marco
>

Doesn't help.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
