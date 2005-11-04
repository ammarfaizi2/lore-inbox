Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161122AbVKDDQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbVKDDQE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 22:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161123AbVKDDQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 22:16:04 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:31083 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1161122AbVKDDQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 22:16:03 -0500
Message-ID: <436AD27E.2050004@m1k.net>
Date: Thu, 03 Nov 2005 22:16:14 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, pb@linuxtv.org, js@linuxtv.org,
       mkrufky@linuxtv.org
Subject: Re: + dvb-add-alternate-stv0297-driver.patch added to -mm tree
References: <200511030341.jA33fvLc024773@shell0.pdx.osdl.net>
In-Reply-To: <200511030341.jA33fvLc024773@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org wrote:

>The patch titled
>
>     dvb: add alternate stv0297-driver
>
>has been added to the -mm tree.  Its filename is
>
>     dvb-add-alternate-stv0297-driver.patch
>
>
>From: Patrick Boettcher <pb@linuxtv.org>
>
>adding special stv0297-driver for the Technisat/B2C2 CableStar2 PCI and USB
>devices (USB untested)
>
>This driver could also be used with other stv0297-based cards, but someone has
>to do it.
>
>The CableStar2's stv0297-driver is tested with QAM32/64/128/256 and has a very
>nice reception-qualitiy.
>
>Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
>Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
>Cc: Johannes Stezenbach <js@linuxtv.org>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/media/dvb/b2c2/Makefile           |    2 
> drivers/media/dvb/b2c2/flexcop-fe-tuner.c |  143 +----
> drivers/media/dvb/b2c2/stv0297_cs2.c      |  776 ++++++++++++++++++++++++++++++
> drivers/media/dvb/b2c2/stv0297_cs2.h      |   51 +
> drivers/media/dvb/b2c2/stv0297_priv.h     |  154 +++++
> 5 files changed, 1029 insertions(+), 97 deletions(-)
>  
>
Andrew-

It has come to my attention that this patch should not have been merged 
upstream.  I apologize for this.  Please drop it from -mm ASAP.

Thank you,

Michael Krufky
