Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUFCGzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUFCGzv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 02:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUFCGzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 02:55:51 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:2735 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S261378AbUFCGzp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 02:55:45 -0400
Subject: RE: idebus setup problem (2.6.7-rc1)
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Auzanneau Gregory <mls@reolight.net>, Jeff Garzik <jgarzik@pobox.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F842DB1E2@PDSMSX403.ccr.corp.intel.com>
References: <3ACA40606221794F80A5670F0AF15F842DB1E2@PDSMSX403.ccr.corp.intel.com>
Content-Type: text/plain
Message-Id: <1086245632.7991.531.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 03 Jun 2004 16:53:53 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-28 at 02:38, Zhu, Yi wrote:
> linux-kernel-owner@vger.kernel.org wrote:
> > Bartlomiej Zolnierkiewicz wrote:
> >> 
> >> It breaks all "idex=" and "hdx=" options.
> >> Please take a look at how ide_setup().
> > 
> > Yes, thanks for pointing out. Maybe we need some wildcard
> > support. If module_param() can do this, that's great.
> 
> Does below change acceptable to make module_param support 
> wildcard '?' ?

Dislike this idea.  If you have hundreds of parameters, maybe it's
supposed to be a PITA?

Rusty,
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

