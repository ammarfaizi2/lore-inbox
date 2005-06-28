Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVF1JUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVF1JUL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVF1JTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 05:19:39 -0400
Received: from bay19-f38.bay19.hotmail.com ([64.4.53.88]:11720 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261900AbVF1JPk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 05:15:40 -0400
Message-ID: <BAY19-F38CD6342E8B675570A6E179CE10@phx.gbl>
X-Originating-IP: [81.155.14.152]
X-Originating-Email: [dcb314@hotmail.com]
From: "d binderman" <dcb314@hotmail.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 28 Jun 2005 09:15:33 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 28 Jun 2005 09:15:33.0496 (UTC) FILETIME=[EFF9D780:01C57BC1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

I just tried to compile the Linux Kernel version 2.6.11.12
with the most excellent Intel C compiler. It said

drivers/usb/host/ohci-hub.c(424): warning #175: subscript out of range
        desc->bitmap [2] = desc->bitmap [3] = 0xff;
                           ^

This is clearly broken code, since there are only up to 16 ports.

Suggest avoid trying to initialise bitmap[ 3].

Regards

David Binderman

_________________________________________________________________
It's fast, it's easy and it's free. Get MSN Messenger 7.0 today! 
http://messenger.msn.co.uk

