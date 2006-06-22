Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161163AbWFVQRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161163AbWFVQRN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWFVQRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:17:13 -0400
Received: from xenotime.net ([66.160.160.81]:37510 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030301AbWFVQRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:17:12 -0400
Date: Thu, 22 Jun 2006 09:19:58 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: danial_thom@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Measuring tools - top and interrupts
Message-Id: <20060622091958.ac824e60.rdunlap@xenotime.net>
In-Reply-To: <20060622152621.92347.qmail@web33301.mail.mud.yahoo.com>
References: <20060622152621.92347.qmail@web33301.mail.mud.yahoo.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 08:26:21 -0700 (PDT) Danial Thom wrote:

> Running 2.6.17, it seems that top is reporting
> 100% idle with a network load of about 75K pps
> (bridged) , which seems unlikely. Is it possible
> that system load accounting is turned off by some
> tunning knob?
> 
> Is there something that shows the current
> interrupts/second in LINUX (such as systat in
> 'BSD)?

You can use/modify http://www.xenotime.net/linux/scripts/sysalive.pl
for interrupts/second (it already does that).

---
~Randy
