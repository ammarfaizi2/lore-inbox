Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269104AbUIRChZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269104AbUIRChZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 22:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbUIRChZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 22:37:25 -0400
Received: from ozlabs.org ([203.10.76.45]:47800 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269104AbUIRChY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 22:37:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16715.21984.137689.407420@cargo.ozlabs.ibm.com>
Date: Fri, 17 Sep 2004 17:23:44 -0400
From: Paul Mackerras <paulus@samba.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       David Gibson <david@gibson.dropbear.id.au>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       linuxppc64-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PPC64] Remove LARGE_PAGE_SHIFT constant
In-Reply-To: <1095446429.4088.3.camel@localhost>
References: <20040917011320.GA6523@zax>
	<20040917170328.GB2179@logos.cnet>
	<1095446429.4088.3.camel@localhost>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen writes:

> Actually, if everybody makes sure to define PMD_SHIFT, we should be able
> to use common macros, right?

No, because LARGE_PAGE_SHIFT != PMD_SHIFT on ppc64.

Paul.
