Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751547AbWHRWgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbWHRWgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWHRWgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:36:54 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:941 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751545AbWHRWgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:36:53 -0400
Subject: Re: [PATCH 2.6.18-rc4] aoe [06/13]: clean up printks via macros
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Ed L. Cashin" <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
In-Reply-To: <6dc082092248e90db76de47c0bd5bd6c@coraid.com>
References: <E1GE8K3-0008Jn-00@kokone.coraid.com>
	 <6dc082092248e90db76de47c0bd5bd6c@coraid.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Aug 2006 23:57:51 +0100
Message-Id: <1155941871.31543.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-18 am 13:39 -0400, ysgrifennodd Ed L. Cashin:
> Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
> 
> Use simple macros to clean up the printks.

This isn't a clean up. Well it is to you but its a confusion to anyone
else meeting the code. We eschew unneccessary obfuscation when macros
are involved.

The older code is longer winded but its *obvious* what it does and it
looks like the rest of the kernel.

