Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130829AbRCFBq5>; Mon, 5 Mar 2001 20:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130831AbRCFBqr>; Mon, 5 Mar 2001 20:46:47 -0500
Received: from [199.183.24.200] ([199.183.24.200]:38955 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130829AbRCFBqh>; Mon, 5 Mar 2001 20:46:37 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200103060146.f261kWY26310@devserv.devel.redhat.com>
Subject: Re: Patch to ymfpci from ALSA 0.99
To: zaitcev@redhat.com (Peter Zaitcev)
Date: Mon, 5 Mar 2001 20:46:32 -0500 (EST)
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010305192524.A19811@devserv.devel.redhat.com> from "Peter Zaitcev" at Mar 05, 2001 07:25:24 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -static unsigned long int	DspInst[] = {
> +static unsigned long DspInst[YDSXG_DSPLENGTH / 4] = {
>  	0x00000081, 0x000001a4, 0x0000000a, 0x0000002f,
>  	0x00080253, 0x01800317, 0x0000407b, 0x0000843f,

This seems wrong (actually I suspect its a continuation of wrongness. What
about 64bit platforms - u32 maybe ?)
