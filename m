Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWJBKDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWJBKDi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 06:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWJBKDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 06:03:38 -0400
Received: from msr45.hinet.net ([168.95.4.145]:53225 "EHLO msr45.hinet.net")
	by vger.kernel.org with ESMTP id S1750721AbWJBKDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 06:03:36 -0400
Message-ID: <024e01c6e609$fef98f60$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       <jgarzik@pobox.com>
References: <1159813596.2576.8.camel@localhost.localdomain> <20061001235151.97ff6d11.akpm@osdl.org>
Subject: Re: [PATCH 5/5] Solve host error problem in low performance embedded system when continune down and up.
Date: Mon, 2 Oct 2006 18:03:23 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In some low performance embedded CPU, if continued to ifconfig up
and down driver. It will cause host error. Driver need to make sure all
counter is clear to zero, and hardware actually stop.

----- Original Message ----- 
From: "Andrew Morton" <akpm@osdl.org>
To: "Jesse Huang" <jesse@icplus.com.tw>
Cc: <linux-kernel@vger.kernel.org>; <netdev@vger.kernel.org>;
<jgarzik@pobox.com>
Sent: Monday, October 02, 2006 2:51 PM
Subject: Re: [PATCH 5/5] Solve host error problem in low performance
embedded system when continune down and up.


On Mon, 02 Oct 2006 14:26:36 -0400
Jesse Huang <jesse@icplus.com.tw> wrote:

> Solve host error problem in low performance embedded system when continune
down and up.

I don't understand that.  Please describe the actual problem which is being
solved,
as well as the means by which it was solved, thanks.


