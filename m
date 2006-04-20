Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWDTK1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWDTK1u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWDTK1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:27:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31142 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750776AbWDTK1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:27:50 -0400
Date: Thu, 20 Apr 2006 03:26:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christian Praehauser <cpraehaus@cosy.sbg.ac.at>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dvb-core: ULE fixes and RFC4326 additions (kernel
 2.6.16)
Message-Id: <20060420032655.475e15ed.akpm@osdl.org>
In-Reply-To: <44475DDD.1020206@cosy.sbg.ac.at>
References: <44465208.5030004@cosy.sbg.ac.at>
	<20060419235349.2b1840c0.akpm@osdl.org>
	<44475DDD.1020206@cosy.sbg.ac.at>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Praehauser <cpraehaus@cosy.sbg.ac.at> wrote:
>
> After correcting the broadcast address i saw that broadcast packets are 
>  not accepted when in "multicast" mode (RX_MODE_MULTI).
>  In the attached version of the patch this was fixed.

This driver would have to be one of the ugliest-looking things in the
kernel.  You must have a strong stomach.

>  --- drivers/media/dvb/dvb-core/dvb_net.c.orig	2006-04-19 15:12:31.000000000 +0200
>  +++ drivers/media/dvb/dvb-core/dvb_net.c	2006-04-20 11:04:18.000000000 +0200

Please prepare future patches in `patch -p1' form:

--- a/drivers/media/dvb/dvb-core/dvb_net.c
+++ a/drivers/media/dvb/dvb-core/dvb_net.c

