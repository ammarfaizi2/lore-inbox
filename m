Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbTFEKZP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 06:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbTFEKZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 06:25:15 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:40925 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263654AbTFEKZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 06:25:15 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200306051038.h55Acgv06131@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.21-rc7-ac1
To: m.watts@eris.qinetiq.com (Mark Watts)
Date: Thu, 5 Jun 2003 06:38:42 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200306051002.54089.m.watts@eris.qinetiq.com> from "Mark Watts" at Meh 05, 2003 10:02:53 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder if you could confirm whether the usb-ohci module should be loaded 
> automatically if I have the following line in modules.conf (this is with 
> 2.4.21-rc6-ac2)
> 
> probeall usb-interface usb-ohci

Depends how your system is set up. The following is working fine on RH
for me.

alias usb-controller ehci-hcd

> I have a Dell 2650 server with a ServerWorks chipset and its not being loaded 
> automagically at boot as it does under my Mandrake kernels.

Could be Mandrake do magic or compile it in ?
