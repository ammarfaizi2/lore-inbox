Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753329AbWKVLst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbWKVLst (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 06:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbWKVLst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 06:48:49 -0500
Received: from bay0-omc1-s31.bay0.hotmail.com ([65.54.246.103]:7099 "EHLO
	bay0-omc1-s31.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1753329AbWKVLss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 06:48:48 -0500
Message-ID: <BAY107-F11C5D88BF00FBB291F3FC09CE30@phx.gbl>
X-Originating-IP: [87.81.120.187]
X-Originating-Email: [dcb314@hotmail.com]
From: "d binderman" <dcb314@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: arch/x86_64/mm/numa.c(124): remark #593: variable "bootmap_size" was set but nev
Date: Wed, 22 Nov 2006 11:48:46 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 22 Nov 2006 11:48:48.0601 (UTC) FILETIME=[2C2F8490:01C70E2C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello there,

I just tried to compile Linux kernel 2.6.18.3 with the Intel C
C compiler.

The compiler said

arch/x86_64/mm/numa.c(124): remark #593: variable "bootmap_size" was set but 
never used

The source code is

    unsigned long start_pfn, end_pfn, bootmap_pages, bootmap_size, 
bootmap_start;

I have checked the source code and I agree with the compiler.
Suggest delete local variable.


Regards

David Binderman

_________________________________________________________________
Find Singles In Your Area Now With Match.com! msnuk.match.com

