Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267916AbUJOBte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267916AbUJOBte (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 21:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268035AbUJOBte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 21:49:34 -0400
Received: from ozlabs.org ([203.10.76.45]:34013 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267916AbUJOBt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 21:49:26 -0400
Subject: Re: [PATCH] s390: network driver changes.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040727145339.GB8126@mschwid3.boeblingen.de.ibm.com>
References: <20040727145339.GB8126@mschwid3.boeblingen.de.ibm.com>
Content-Type: text/plain
Message-Id: <1097804975.22673.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 11:49:35 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 00:53, Martin Schwidefsky wrote:
> +extern DEFINE_PER_CPU(char[256], iucv_dbf_txt_buf);

Hmm, DECLARE_PER_CPU() please....

Thanks,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

