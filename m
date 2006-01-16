Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWAPVv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWAPVv0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 16:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWAPVvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 16:51:25 -0500
Received: from smtp-out-01.utu.fi ([130.232.202.171]:65242 "EHLO
	smtp-out-01.utu.fi") by vger.kernel.org with ESMTP id S1750995AbWAPVvZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 16:51:25 -0500
Date: Mon, 16 Jan 2006 23:51:17 +0200
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: Shared memory usage
In-reply-to: <Pine.LNX.4.61.0601160909590.22754@chaos.analogic.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Message-id: <200601162351.19159.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <Pine.LNX.4.61.0601160909590.22754@chaos.analogic.com>
User-Agent: KMail/1.6.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 January 2006 16:15, linux-os (Dick Johnson) wrote:

> /proc/meminfo does not show any shared memory in use!

echo m > /proc/sysrq-trigger ; dmesg | grep shared

> available in /proc as it was in the past before it was
> removed.

I think this was all over FAQs covering 2.4 -> 2.6 transition...
