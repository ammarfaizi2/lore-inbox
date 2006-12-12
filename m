Return-Path: <linux-kernel-owner+w=401wt.eu-S1750822AbWLLBX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWLLBX0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 20:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWLLBX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 20:23:26 -0500
Received: from gw.goop.org ([64.81.55.164]:56675 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbWLLBXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 20:23:25 -0500
Message-ID: <457E0460.4030107@goop.org>
Date: Mon, 11 Dec 2006 17:22:40 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Why disable vdso by default with CONFIG_PARAVIRT?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

What problem do they cause together?  There's certainly no problem with
Xen+vdso (in fact, its actually very useful so that it picks up the
right libc with Xen-friendly TLS).

    J
