Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWJ0X1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWJ0X1u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 19:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWJ0X1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 19:27:50 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:57351 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750891AbWJ0X1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 19:27:49 -0400
Message-ID: <454295F4.1050001@superbug.co.uk>
Date: Sat, 28 Oct 2006 00:27:48 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.7 (X11/20061020)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Latency measurements
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If I have an application using poll() to wait for an event, and that 
event it triggered by an interrupt handling routine in the kernel. E.g. 
DMA transaction completed. Is there any way for me to measure the 
latency between the kernel interrupt, and my application returning from 
the poll() call?

James

