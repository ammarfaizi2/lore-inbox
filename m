Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbUKXAJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbUKXAJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 19:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbUKXAEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 19:04:41 -0500
Received: from lucidpixels.com ([66.45.37.187]:9376 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261357AbUKWRnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 12:43:14 -0500
Date: Tue, 23 Nov 2004 12:43:12 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: CONFIG_TULIP_NAPI_HW_MITIGATION latency question.
Message-ID: <Pine.LNX.4.61.0411231242090.3740@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"at the cost of a small latency"

How much additional latency is added with this option enabled?

5ms? 10ms?

-> Use Interrupt Mitigation
   x CONFIG_TULIP_NAPI_HW_MITIGATION:
   x Use HW to reduce RX interrupts. Not strict necessary since NAPI 
reduces RX interrupts but itself. Although this reduces RX interrupts even at 
low levels traffic at the cost of a small latency. 
x
   x If in doubt, say Y. 
x
