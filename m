Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262489AbSKDA0U>; Sun, 3 Nov 2002 19:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263991AbSKDA0T>; Sun, 3 Nov 2002 19:26:19 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:6807 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262489AbSKDA0T>; Sun, 3 Nov 2002 19:26:19 -0500
Date: Sun, 3 Nov 2002 19:32:48 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200211040032.gA40Wms01503@devserv.devel.redhat.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Cleanup bitfield endianess mess
In-Reply-To: <mailman.1036366080.20423.linux-kernel2news@redhat.com>
References: <mailman.1036366080.20423.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch defines new BITFIELDx macros to clean up the #ifdef mess with 
> bitfields, and starts the conversion off with the IDE/ATAPI files.

I think it may be more reliable to talk to gcc people
about adding -fprohibit-bitfields to the compiler and eradicate
bitfields from the kernel as such. If I was the benevolent
dictator, that is what I would have done (consider yourself
fortunate I'm not :-)

-- Pete
