Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161212AbVKSC7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161212AbVKSC7X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 21:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161226AbVKSC7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 21:59:23 -0500
Received: from [81.2.110.250] ([81.2.110.250]:59100 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1161212AbVKSC7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 21:59:23 -0500
Subject: Re: [PATCH 2/5] I2O: SPARC fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: Markus.Lidel@shadowconnect.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051118.172230.126076770.davem@davemloft.net>
References: <437B254E.9040909@shadowconnect.com>
	 <20051116.111843.23450955.davem@davemloft.net>
	 <437E7ADB.5080200@shadowconnect.com>
	 <20051118.172230.126076770.davem@davemloft.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Nov 2005 03:30:39 +0000
Message-Id: <1132371039.5238.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-11-18 at 17:22 -0800, David S. Miller wrote:
> Ho hum, I guess keep it a config option for now until we find a
> way to auto-detect this reliably.

The notify functionality is mandatory. You are seeing the same cards
fail on sparc but work on x86. This sounds to me a lot more like an
unfound endian bug that needs fixing than a real lack of support

