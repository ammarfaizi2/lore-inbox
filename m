Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262691AbSJGT4S>; Mon, 7 Oct 2002 15:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbSJGT4R>; Mon, 7 Oct 2002 15:56:17 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:54811 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262691AbSJGT4Q>; Mon, 7 Oct 2002 15:56:16 -0400
Date: Mon, 7 Oct 2002 16:01:51 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200210072001.g97K1p726546@devserv.devel.redhat.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: Linux v2.5.41
In-Reply-To: <mailman.1034018941.1657.linux-kernel2news@redhat.com>
References: <mailman.1034018941.1657.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> David S. Miller <davem@redhat.com>:
>   o USB: usbkbd fix

Dave, why do you even bother with usbkbd? It MUST DIE and get
removed. Please, do me a favour: kill CONFIG_USB_KBD from your
configuration and let me and Vojtech know if something
actually fails. The hid must support all devices which were
supported bye usbkbd.

-- Pete
