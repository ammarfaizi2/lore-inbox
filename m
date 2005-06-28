Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVF1GkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVF1GkO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVF1GjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:39:15 -0400
Received: from [213.184.188.19] ([213.184.188.19]:7684 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S262011AbVF1GiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:38:02 -0400
Message-Id: <200506280637.JAA07333@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Kswapd flaw
Date: Tue, 28 Jun 2005 09:37:41 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20050627155807.GA10171@logos.cnet>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcV7X8b1hzRZ6+7PTdCTyhvYZ/zmLAARlbNQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Jun 27, 2005 at 11:04:08PM +0300, Al Boldi wrote:
> 
> In 2.4.31 kswapd starts paging during OOMs even w/o swap enabled.
> 
> Is there a way to fix/disable this behaviour?

Marcelo,

Kswapd starts evicting processes to fullfil a malloc, when it should just
deny it because there is no swap.

