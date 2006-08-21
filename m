Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbWHUH2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWHUH2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 03:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWHUH2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 03:28:54 -0400
Received: from msr30.hinet.net ([168.95.4.130]:4570 "EHLO msr30.hinet.net")
	by vger.kernel.org with ESMTP id S965009AbWHUH2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 03:28:54 -0400
Message-ID: <00d101c6c4f3$6aa0fbf0$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <akpm@osdl.org>
References: <1155841780.4532.21.camel@localhost.localdomain> <44E5A1E1.1060500@pobox.com>
Subject: Re: [PATCH 6/6] IP100A Solve host error problem when in low	performance embedded
Date: Mon, 21 Aug 2006 15:28:34 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff:
> (4) are you certain that DMACtrl should be read as a 32-bit register?
> In other code, you treat it as a 16-bit register.

DMACtrl can read and write both in 16-bit and 32-bit. I will modify all
of then as 32-bit.

Thanks.

Jesse


