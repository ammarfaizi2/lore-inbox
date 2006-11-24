Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756545AbWKXK4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756545AbWKXK4x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 05:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757342AbWKXK4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 05:56:53 -0500
Received: from bay0-omc1-s3.bay0.hotmail.com ([65.54.246.75]:64740 "EHLO
	bay0-omc1-s3.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1756545AbWKXK4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 05:56:52 -0500
Message-ID: <BAY107-F9805F8D4EBF632DB1172B9CE10@phx.gbl>
X-Originating-IP: [87.81.120.187]
X-Originating-Email: [dcb314@hotmail.com]
From: "d binderman" <dcb314@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel/power/disk.c(41): remark #593: variable "error" was set but never used   
Date: Fri, 24 Nov 2006 10:56:50 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 24 Nov 2006 10:56:52.0362 (UTC) FILETIME=[3F96AEA0:01C70FB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello there,

I just tried to compile Linux kernel 2.6.18.3 with the Intel C
C compiler.

The compiler said

1.

kernel/power/disk.c(41): remark #593: variable "error" was set but never 
used

The source code is

    int error = 0;

2.

kernel/power/disk.c(165): remark #593: variable "error" was set but never 
used

The source code is

    int error;

I have checked the source code and I agree with the compiler.
Suggest delete local variables.

Regards

David Binderman

_________________________________________________________________
Be the first to hear what's new at MSN - sign up to our free newsletters! 
http://www.msn.co.uk/newsletters

