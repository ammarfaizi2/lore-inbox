Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVGEKul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVGEKul (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 06:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVGEKul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 06:50:41 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:38357 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261815AbVGEKgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 06:36:40 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Masatake YAMATO <jet@gyve.org>
Subject: Re: [PATCH] Avoid to use kmalloc in usb/core/message.c
Date: Tue, 5 Jul 2005 12:36:37 +0200
User-Agent: KMail/1.8.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050705.191221.92572119.jet@gyve.org>
In-Reply-To: <20050705.191221.92572119.jet@gyve.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507051236.37288.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder why the invocations of kmalloc are needed in these functions.

Because some architectures can't do DMA to/from the stack.

All the best,

Duncan.
