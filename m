Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266876AbUITQ5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266876AbUITQ5c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 12:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbUITQ4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 12:56:19 -0400
Received: from mail.convergence.de ([212.227.36.84]:24763 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S266871AbUITQrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 12:47:31 -0400
Message-ID: <414F0970.4060603@linuxtv.org>
Date: Mon, 20 Sep 2004 18:46:40 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6][12.1/14] DVB: add kernel message classifiers
References: <414AF41A.6060009@linuxtv.org> <414AF461.4050707@linuxtv.org> <414AF4CE.7000000@linuxtv.org> <414AF51D.4060308@linuxtv.org> <414AF569.2020803@linuxtv.org> <414AF5BF.4020401@linuxtv.org> <414AF605.5040605@linuxtv.org> <414AF65F.2010200@linuxtv.org> <414AF6B1.9040706@linuxtv.org> <414AF71B.5070702@linuxtv.org> <20040920111118.GA6035@titan.lahn.de>
In-Reply-To: <20040920111118.GA6035@titan.lahn.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Could you please apply the following patch on top, which adds
> kernel message classifiers to printk()-calls in av7110_av.c
> 
> If you don't to apply the whole patch, please at least remove those two
> printk() calls in av7110_ioctl() line 267 and 270, because on my Siemens
> DVB-C 1.6 they are printed every second and fill up syslog! (BTW: Stereo
> detection never worked for me)

I've taken the time and reworked the debug message logic in the av7110 
driver. It depended on the saa7146 driver and used horrible macros 
anyway, so I converted them alltogether.

I'll try to get this into 2.6.9 as well.

CU
Michael.
