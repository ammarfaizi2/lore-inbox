Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVF1JUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVF1JUF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVF1JT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 05:19:28 -0400
Received: from bay19-f15.bay19.hotmail.com ([64.4.53.65]:36327 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261995AbVF1JQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 05:16:58 -0400
Message-ID: <BAY19-F15587C5037C178B447330E9CE10@phx.gbl>
X-Originating-IP: [81.155.14.152]
X-Originating-Email: [dcb314@hotmail.com]
From: "d binderman" <dcb314@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: variable used before it is set
Date: Tue, 28 Jun 2005 09:16:56 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 28 Jun 2005 09:16:57.0206 (UTC) FILETIME=[21DEF960:01C57BC2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried to compile the Linux Kernel version 2.6.11.12
with the most excellent Intel C compiler. It said

net/bridge/netfilter/ebt_log.c(91): remark #592: variable "u" is used before 
its value is set
        printk(" IP tos=0x%02X, IP proto=%d", u.iph.tos,
                                              ^
I agree with the compiler. Suggest code rework.

Regards

David Binderman

_________________________________________________________________
Want to block unwanted pop-ups? Download the free MSN Toolbar now!  
http://toolbar.msn.co.uk/

