Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031353AbWKUTqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031353AbWKUTqu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 14:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031354AbWKUTqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 14:46:50 -0500
Received: from bay0-omc3-s32.bay0.hotmail.com ([65.54.246.232]:20216 "EHLO
	bay0-omc3-s32.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1031353AbWKUTqt (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 14:46:49 -0500
Message-ID: <BAY107-F214E963C5A93489762562E9CEC0@phx.gbl>
X-Originating-IP: [87.81.120.187]
X-Originating-Email: [dcb314@hotmail.com]
From: "d binderman" <dcb314@hotmail.com>
To: Linux-Kernel@vger.kernel.org
Subject: arch/x86_64/kernel/apic.c(701): remark #593: variable "ver" was set but never us
Date: Tue, 21 Nov 2006 19:46:46 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 21 Nov 2006 19:46:48.0946 (UTC) FILETIME=[C8971D20:01C70DA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello there,

I just tried to compile Linux kernel 2.6.18.3 with the Intel C
C compiler.

The compiler said

arch/x86_64/kernel/apic.c(701): remark #593: variable "ver" was set but 
never used

The source code is

    unsigned int lvtt_value, tmp_value, ver;

I have checked the source code and I agree with the compiler.
Suggest delete local variable.

Regards

David Binderman

_________________________________________________________________
Be the first to hear what's new at MSN - sign up to our free newsletters! 
http://www.msn.co.uk/newsletters

