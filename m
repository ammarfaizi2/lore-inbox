Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751875AbWFUAYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbWFUAYX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 20:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWFUAYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 20:24:23 -0400
Received: from gw.goop.org ([64.81.55.164]:36261 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751875AbWFUAYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 20:24:22 -0400
Message-ID: <449891B9.3060409@goop.org>
Date: Tue, 20 Jun 2006 17:24:25 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       jeremy@xensource.com
Subject: Re: [PATCH 2.6.17] Clean up and refactor i386 sub-architecture setup
References: <44988803.5090305@goop.org> <44988E08.9070000@vmware.com>
In-Reply-To: <44988E08.9070000@vmware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> This looks awesome.   Are there any plans to get these 
> sub-architectures to work with the generic subarch?  Seems the next 
> logical step would be putting each mach-*/*.o into separated namespaces.

I haven't looked at that.  This patch was intended to be a very simple 
uncontroversial rearrangement, in preparation for the Xen subarch, and 
to just clean up a corner of the kernel which seems to have gotten a bit 
warty.  Chris just sent me your patches from March which look like they 
cover a lot of the same ground, but I haven't looked at them in detail yet.

    J
