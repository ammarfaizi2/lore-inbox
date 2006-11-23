Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757327AbWKWKMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757327AbWKWKMJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 05:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757328AbWKWKMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 05:12:09 -0500
Received: from bay0-omc2-s37.bay0.hotmail.com ([65.54.246.173]:20137 "EHLO
	bay0-omc2-s37.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1757327AbWKWKMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 05:12:06 -0500
Message-ID: <BAY107-F28F506ED79A35F4FF31CF39CE20@phx.gbl>
X-Originating-IP: [87.81.120.187]
X-Originating-Email: [dcb314@hotmail.com]
From: "d binderman" <dcb314@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel/hrtimer.c(511): remark #593: variable "base" was set but never used    
Date: Thu, 23 Nov 2006 10:12:03 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 23 Nov 2006 10:12:06.0173 (UTC) FILETIME=[D41504D0:01C70EE7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello there,

I just tried to compile Linux kernel 2.6.18.3 with the Intel C
C compiler.

The compiler said

kernel/hrtimer.c(511): remark #593: variable "base" was set but never used

The source code is

    struct hrtimer_base *base;

I have checked the source code and I agree with the compiler.
Suggest delete local variable.

Regards

David Binderman

_________________________________________________________________
Be the first to hear what's new at MSN - sign up to our free newsletters! 
http://www.msn.co.uk/newsletters

