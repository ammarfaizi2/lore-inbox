Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVAJUYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVAJUYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbVAJUWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:22:38 -0500
Received: from hera.kernel.org ([209.128.68.125]:3283 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262490AbVAJULz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:11:55 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] /driver/net/wan/sbs520
Date: Mon, 10 Jan 2005 12:11:46 -0800
Organization: Open Source Development Lab
Message-ID: <20050110121146.384e1ca3@dxpl.pdx.osdl.net>
References: <4F23E557A0317D45864097982DE907941A3383@pilotmail.sbscorp.sbs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1105387905 5468 172.20.1.103 (10 Jan 2005 20:11:45 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 10 Jan 2005 20:11:45 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 0.9.13 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Like most vendor drivers, this looks ugly full of obfuscating typedef's
and MixedCase. Please make it conform to linux style.

Also, all global's should be static where possible to avoid name space pollution.
Replace volatile with wmb() and rmb() which is probably what you need anyway.
Don't bury volatile inside typedef.s


