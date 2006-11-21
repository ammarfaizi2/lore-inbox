Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031378AbWKUUFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031378AbWKUUFa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031380AbWKUUFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:05:30 -0500
Received: from bay0-omc1-s16.bay0.hotmail.com ([65.54.246.88]:33443 "EHLO
	bay0-omc1-s16.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1031378AbWKUUF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:05:29 -0500
Message-ID: <BAY107-F1209C38A8D8079599E1ECF9CEC0@phx.gbl>
X-Originating-IP: [87.81.120.187]
X-Originating-Email: [dcb314@hotmail.com]
From: "d binderman" <dcb314@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: arch/x86_64/kernel/smpboot.c(273): remark #593: variable "bound" was set but nev
Date: Tue, 21 Nov 2006 20:05:25 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 21 Nov 2006 20:05:28.0530 (UTC) FILETIME=[63EA1320:01C70DA8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello there,

I just tried to compile Linux kernel 2.6.18.3 with the Intel C
C compiler.

The compiler said

arch/x86_64/kernel/smpboot.c(273): remark #593: variable "bound" was set but 
never used

The source code is

    unsigned long flags, rt, master_time_stamp, bound;

I have checked the source code and I agree with the compiler.
Suggest delete local variable.

Regards

David Binderman

_________________________________________________________________
Download the new Windows Live Toolbar, including Desktop search! 
http://toolbar.live.com/?mkt=en-gb

