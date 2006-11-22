Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752942AbWKVLp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbWKVLp3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 06:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753013AbWKVLp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 06:45:29 -0500
Received: from bay0-omc2-s16.bay0.hotmail.com ([65.54.246.152]:46089 "EHLO
	bay0-omc2-s16.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1752942AbWKVLp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 06:45:29 -0500
Message-ID: <BAY107-F16375715795A91CEA1E2D99CE30@phx.gbl>
X-Originating-IP: [87.81.120.187]
X-Originating-Email: [dcb314@hotmail.com]
From: "d binderman" <dcb314@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: arch/x86_64/kernel/pci-calgary.c(600): remark #593: variable "bbar" was set but 
Date: Wed, 22 Nov 2006 11:45:24 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 22 Nov 2006 11:45:28.0273 (UTC) FILETIME=[B4C7E410:01C70E2B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello there,

I just tried to compile Linux kernel 2.6.18.3 with the Intel C
C compiler.

The compiler said

arch/x86_64/kernel/pci-calgary.c(600): remark #593: variable "bbar" was set 
but never used
arch/x86_64/kernel/pci-calgary.c(601): remark #593: variable "busnum" was 
set but never used

The source code is

    void __iomem *bbar;
    unsigned char busnum;

I have checked the source code and I agree with the compiler.
Suggest delete local variables.

Regards

David Binderman

_________________________________________________________________
Be the first to hear what's new at MSN - sign up to our free newsletters! 
http://www.msn.co.uk/newsletters

