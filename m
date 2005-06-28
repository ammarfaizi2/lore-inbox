Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVF1JOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVF1JOt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVF1JNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 05:13:06 -0400
Received: from bay19-f25.bay19.hotmail.com ([64.4.53.75]:11176 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261836AbVF1JMx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 05:12:53 -0400
Message-ID: <BAY19-F255ACFD14A7CB3309260039CE10@phx.gbl>
X-Originating-IP: [81.155.14.152]
X-Originating-Email: [dcb314@hotmail.com]
From: "d binderman" <dcb314@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: array subscript out of range
Date: Tue, 28 Jun 2005 09:12:52 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 28 Jun 2005 09:12:52.0745 (UTC) FILETIME=[90292F90:01C57BC1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

I just tried to compile the Linux Kernel version 2.6.11.12
with the most excellent Intel C compiler. It said

drivers/media/video/bt819.c(239): warning #175: subscript out of range
    init[0x19*2-1] = decoder->norm == 0 ? 115 : 93; /* Chroma burst delay */
        ^

This is clearly broken code, since the init data is declared
with 44 elements, but the index is for number 49.

Suggest code rework.

_________________________________________________________________
Be the first to hear what's new at MSN - sign up to our free newsletters! 
http://www.msn.co.uk/newsletters

