Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270561AbUJTXaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270561AbUJTXaT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270469AbUJTXaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:30:17 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:28167 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S270561AbUJTXQ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:16:56 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Wed, 20 Oct 2004 16:16:34 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKOEIDPCAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <4176E2BE.5070806@nortelnetworks.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 20 Oct 2004 15:53:09 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 20 Oct 2004 15:53:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 2) my proposal makes them work as expected in the meantime, with
> a performance cost
>
> Chris

	Perhaps I missed the details, but under your proposal, how do you predict
at 'select' time what mode the socket will be in at 'recvmsg' time?!

	DS


