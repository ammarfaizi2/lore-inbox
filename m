Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758140AbWK0MfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758140AbWK0MfV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758139AbWK0MfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:35:21 -0500
Received: from bay0-omc2-s1.bay0.hotmail.com ([65.54.246.137]:42666 "EHLO
	bay0-omc2-s1.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1758137AbWK0MfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:35:19 -0500
Message-ID: <BAY107-F24D4E1EDA745C0EBACC9139CE60@phx.gbl>
X-Originating-IP: [87.81.120.187]
X-Originating-Email: [dcb314@hotmail.com]
From: "d binderman" <dcb314@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: mm/fremap.c(104): remark #593: variable "pte_val" was set but never used    
Date: Mon, 27 Nov 2006 12:35:17 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 27 Nov 2006 12:35:18.0856 (UTC) FILETIME=[7F5F6480:01C71220]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello there,

I just tried to compile Linux kernel 2.6.18.3 with the Intel C
C compiler.

The compiler said

mm/fremap.c(104): remark #593: variable "pte_val" was set but never used

The source code is

    pte_t pte_val;

I have checked the source code and I agree with the compiler.
Suggest delete local variable.


Regards

David Binderman

_________________________________________________________________
Be the first to hear what's new at MSN - sign up to our free newsletters! 
http://www.msn.co.uk/newsletters

