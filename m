Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTFJUFv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTFJUE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:04:28 -0400
Received: from jma24.plus.com ([212.159.46.210]:58714 "EHLO lion")
	by vger.kernel.org with ESMTP id S262290AbTFJUC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 16:02:58 -0400
From: "John Appleby" <john@dnsworld.co.uk>
To: <xyko_ig@ig.com.br>, <linux-kernel@vger.kernel.org>
Subject: RE: Wrong number of cpus detected/reported
Date: Tue, 10 Jun 2003 21:21:39 +0100
Message-ID: <434747C01D5AC443809D5FC540501131569E@bobcat.unickz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <434747C01D5AC443809D5FC5405011310B7169@bobcat.unickz.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After the upgrade the system is reporting that the machine has 8 cpu
> instead of 4. I have been looking for some kind of information on the
> Internet (www.google.com/linux) about that but I didn't have success.

I suspect that it is identifying 4 Xeon CPUs with Hyperthreading, which
will correctly double the amount of processors your kernel thinks you
have. Intel's Hyperthreading

This ought to be a good thing... the only thing I don't quite understand
is that I thought Hyperthreading was added in 2.4.17.

Regards,

John


