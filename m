Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756228AbWKVSIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228AbWKVSIE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756297AbWKVSID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:08:03 -0500
Received: from bay0-omc2-s13.bay0.hotmail.com ([65.54.246.149]:47808 "EHLO
	bay0-omc2-s13.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1756228AbWKVSIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:08:01 -0500
Message-ID: <BAY107-F21127643F7E88F7E18D48C9CE30@phx.gbl>
X-Originating-IP: [87.81.120.187]
X-Originating-Email: [dcb314@hotmail.com]
From: "d binderman" <dcb314@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: arch/x86_64/ia32/sys_ia32.c(539): remark #593: variable "ret" was set but never 
Date: Wed, 22 Nov 2006 18:07:58 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 22 Nov 2006 18:08:00.0852 (UTC) FILETIME=[25958140:01C70E61]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello there,

I just tried to compile Linux kernel 2.6.18.3 with the Intel C
C compiler.

The compiler said

arch/x86_64/ia32/sys_ia32.c(539): remark #593: variable "ret" was set but 
never used

The source code is

    int ret;

I have checked the source code and I agree with the compiler.
Suggest delete local variable.

Regards

David Binderman

_________________________________________________________________
Download the new Windows Live Toolbar, including Desktop search! 
http://toolbar.live.com/?mkt=en-gb

