Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268919AbUIQS0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268919AbUIQS0k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 14:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUIQS0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 14:26:40 -0400
Received: from hera.kernel.org ([63.209.29.2]:63958 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S268919AbUIQSZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 14:25:49 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [RFT/PATCH 2.6] ALPS touchpad driver
Date: Fri, 17 Sep 2004 11:25:41 -0700
Organization: Open Source Development Lab
Message-ID: <20040917112541.0363ecb0@dell_ss3.pdx.osdl.net>
References: <200407110045.08208.dtor_core@ameritech.net>
	<m3u0vsszrq.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1095445541 7648 172.20.1.60 (17 Sep 2004 18:25:41 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Fri, 17 Sep 2004 18:25:41 +0000 (UTC)
X-Newsreader: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well my Alps touchpad on Fujitsu S6000 reports:
E6 report: 00 00 00 

and if I hack this alps.c to accept that, it just locks up
after the E7 report :-(

