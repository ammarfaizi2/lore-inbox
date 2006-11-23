Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757323AbWKWKIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757323AbWKWKIR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 05:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757324AbWKWKIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 05:08:17 -0500
Received: from bay0-omc2-s22.bay0.hotmail.com ([65.54.246.158]:28769 "EHLO
	bay0-omc2-s22.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1757323AbWKWKIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 05:08:16 -0500
Message-ID: <BAY107-F2847307957C37B16EA55729CE20@phx.gbl>
X-Originating-IP: [87.81.120.187]
X-Originating-Email: [dcb314@hotmail.com]
From: "d binderman" <dcb314@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: fs/binfmt_elf.c(548): remark #593: variable "have_pt_gnu_stack" was set but neve
Date: Thu, 23 Nov 2006 10:08:13 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 23 Nov 2006 10:08:15.0549 (UTC) FILETIME=[4A9E96D0:01C70EE7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello there,

I just tried to compile Linux kernel 2.6.18.3 with the Intel C
C compiler.

The compiler said

arch/x86_64/ia32/../../../fs/binfmt_elf.c(548): remark #593: variable 
"have_pt_gnu_stack" was set but never used

The source code is

    int have_pt_gnu_stack, executable_stack = EXSTACK_DEFAULT;

I have checked the source code and I agree with the compiler.
Suggest delete local variable.

Regards

David Binderman

_________________________________________________________________
Be the first to hear what's new at MSN - sign up to our free newsletters! 
http://www.msn.co.uk/newsletters

