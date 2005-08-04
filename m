Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVHDBCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVHDBCM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 21:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVHDA7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 20:59:35 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:12022 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261732AbVHDA6N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 20:58:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XS1yCAyFt3rSLJQdkXsRDSM7qV7LISjLpeUcbj3maQVZc6AuS5fm8b9KFLJMUAcPjH7YohAGhnQSOZExmHW/gPNBKvXQn26H/NY1GyNGu+aHMLBEuNCT1nPPqsy3oVrf+U5oj+j3lVPsdatTY3kCbU+1KBix3HyP0cFcod+wuAE=
Message-ID: <86802c44050803175873fb0569@mail.gmail.com>
Date: Wed, 3 Aug 2005 17:58:11 -0700
From: yhlu <yhlu.kernel@gmail.com>
Reply-To: yhlu <yhlu.kernel@gmail.com>
To: Roland Dreier <rolandd@cisco.com>
Subject: Re: [PATCH 1/2] [IB/cm]: Correct CM port redirect reject codes
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20057281331.7vqhiAJ1Yc0um2je@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20057281331.dR47KhjBsU48JfGE@cisco.com>
	 <20057281331.7vqhiAJ1Yc0um2je@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland,

In LinuxBIOS, If I enable the prefmem64 to use real 64 range. the IB
driver in Kernel can not be loaded.

YH

PCI: 00:18.0 1c1 <- [0x0000001000 - 0x0000003fff] io <node 0 link 1>
PCI: 00:18.0 1b9 <- [0xfce0000000 - 0xfcf07fffff] prefmem <node 0 link 1>
PCI: 00:18.0 1b1 <- [0x00fc000000 - 0x00fd2fffff] mem <node 0 link 1>           
PCI: 01:0f.0 24 <- [0xfce0000000 - 0xfcf07fffff] bus 4 prefmem
PCI: 01:0f.0 20 <- [0x00fd100000 - 0x00fd1fffff] bus 4 mem
PCI: 04:00.0 10 <- [0x00fd100000 - 0x00fd1fffff] mem64
PCI: 04:00.0 18 <- [0xfcf0000000 - 0xfcf07fffff] prefmem64
PCI: 04:00.0 20 <- [0xfce0000000 - 0xfcefffffff] prefmem64                      

ib_mthca: Mellanox InfiniBand HCA driver v0.06 (June 23, 2005)
ib_mthca: Initializing Mellanox Technologies MT25208 InfiniHost III Ex (Tavor c)
ib_mthca 0000:04:00.0: Failed to initialize queue pair table, aborting.
ib_mthca: probe of 0000:04:00.0 failed with error -16
