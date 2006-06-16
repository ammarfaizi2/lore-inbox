Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWFPToq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWFPToq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 15:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWFPToq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 15:44:46 -0400
Received: from orange.blizznet.at ([213.143.111.1]:49370 "EHLO
	orange.hybridz.net") by vger.kernel.org with ESMTP id S1751435AbWFPTop
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 15:44:45 -0400
From: "Ralf Dauberschmidt" <rfk@digitalstyle.de>
To: <linux-kernel@vger.kernel.org>
Subject: AW: sock_alloc() symbol removed in 2.6.10
Date: Fri, 16 Jun 2006 21:44:37 +0200
Message-ID: <002a01c6917d$4ddbfc80$0200000a@redstorm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcaRXWigh27bDtXuQHGn5Dj5LJD7OwAHsR9Q
In-Reply-To: <1150473371.3070.0.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> what driver are you looking at that wants to use it?

At university we are currently porting a project from a 2.4 series kernel to
a recent 2.6 series kernel. This project uses the sock_alloc() function.


Stephen Smalley wrote:
> Also, it would be better to use sock_create_lite() to ensure proper
> handling by the security subsystem.  See:
> http://marc.theaimsgroup.com/?l=git-commits-head&m=108407590404054&w=2

Thanks for the hint, I will use sock_create_lite() instead.


Regards,
 Ralf Dauberschmidt

