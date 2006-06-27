Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030735AbWF0IAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030735AbWF0IAW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030747AbWF0IAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:00:22 -0400
Received: from nn7.excitenetwork.com ([207.159.120.61]:37445 "EHLO myway.com")
	by vger.kernel.org with ESMTP id S1030735AbWF0IAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:00:20 -0400
To: linux-kernel@vger.kernel.org
Subject: Calling kernel functions from kprobes/jprobes
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: ID = 67d9deadc6717fb23d486b0daa7f46a6
Reply-to: samuelkorpi@myway.com
From: "Samuel" <samuelkorpi@myway.com>
MIME-Version: 1.0
X-Mailer: PHP
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Message-Id: <20060627080021.453306776E@mprdmxin.myway.com>
Date: Tue, 27 Jun 2006 04:00:21 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am using kprobes/jprobes to try and understand how IP options are handled in the kernel. From one of these probes I want to call another function inside the kernel, namely ip_options_get_from_user. It is defined in net/ipv4/ip_options.c and declared in include/net/ip.h. I have included the ip.h header file in my probe, but on compilation I get a warning saying the function is undefined. Also, inserting the probe fails - "Unknown symbol in module".

Any help would be appreciated.

BR,

Samuel Korpi

_______________________________________________
No banners. No pop-ups. No kidding.
Make My Way  your home on the Web - http://www.myway.com


