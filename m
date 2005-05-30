Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVE3QsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVE3QsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 12:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVE3QsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 12:48:11 -0400
Received: from 65-102-103-67.albq.qwest.net ([65.102.103.67]:38091 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261648AbVE3QsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 12:48:08 -0400
Date: Mon, 30 May 2005 10:51:43 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: jayush luniya <jayu_11@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: HOTPLUG CPU Support for SMT
In-Reply-To: <20050530152534.21912.qmail@web32806.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.61.0505301050141.12903@montezuma.fsmlabs.com>
References: <20050530152534.21912.qmail@web32806.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2005, jayush luniya wrote:

> I have been looking at the CONFIG_HOTPLUG_CPU option
> in the Linux Kernel. The option works for IA64, PPP64,
> S390 architectures. I am doing my research on SMT
> architecture and want to write a kernel module that
> can dynamically enable/disable SMT, so that I can
> switch between uniprocessor mode and SMT mode. So is
> it possible to use the CONFIG_HOTPLUG_CPU option to
> dynamically enable/disable a logical processor by
> performing a logical removal of the CPU since the
> hardware does not support CPU hotplugging? Also I
> would like to know how efficient such an
> implementation would be? 
> 
> I would really appreciate if anyone could provide me
> suggestions and any specific patches related to this
> work.

Yes, older 2.6-mm kernel (2.6.10-mm) trees have the "toy" i386 hotplug 
cpu implementation which does what you want.
