Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264646AbTFAPQr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 11:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbTFAPQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 11:16:47 -0400
Received: from main.gmane.org ([80.91.224.249]:648 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264646AbTFAPQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 11:16:46 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@falooley.org>
Subject: Re: [PATCH] amd76x_pm port to 2.5.70
Date: Sun, 1 Jun 2003 15:27:52 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <slrnbdk6vt.m0b.lunz@orr.homenet>
References: <20030531183321.GA3408@varg.dyndns.org>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

psavo@iki.fi said:
> +++ linux-2.5.70-mod/drivers/char/amd76x_pm.c	2003-05-31 20:55:37.000000000 +0300

What is this thing doing in drivers/char? It has nothing whatsoever to
do with char devices. Couldn't this be handled by the ACPI idle loop?

Jason

