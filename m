Return-Path: <linux-kernel-owner+w=401wt.eu-S1750849AbWLLBmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWLLBmY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 20:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWLLBmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 20:42:24 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:47181 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbWLLBmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 20:42:23 -0500
Message-ID: <457E08FE.6050600@vmware.com>
Date: Mon, 11 Dec 2006 17:42:22 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why disable vdso by default with CONFIG_PARAVIRT?
References: <457E0460.4030107@goop.org>
In-Reply-To: <457E0460.4030107@goop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> Hi Andi,
>
> What problem do they cause together?  There's certainly no problem with
> Xen+vdso (in fact, its actually very useful so that it picks up the
> right libc with Xen-friendly TLS).
>   

Methinks the compat VDSO support got broken in the config?  Paravirt + 
COMPAT_VDSO are incompatible.
