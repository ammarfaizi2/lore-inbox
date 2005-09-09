Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965223AbVIIBL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbVIIBL7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 21:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbVIIBL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 21:11:59 -0400
Received: from ozlabs.org ([203.10.76.45]:35986 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965223AbVIIBL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 21:11:59 -0400
Subject: Re: [PATCH] module-init-tools: don't do '-' substitutions in depmod
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bill Nottingham <notting@redhat.com>
Cc: linux-kernel@vger.kernel.org, adam@yggdrasil.com
In-Reply-To: <20050908195633.GB9884@nostromo.devel.redhat.com>
References: <20050908195633.GB9884@nostromo.devel.redhat.com>
Content-Type: text/plain
Date: Fri, 09 Sep 2005 11:11:59 +1000
Message-Id: <1126228319.25110.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-08 at 15:56 -0400, Bill Nottingham wrote:
> The attached patch removes the '-' for '_' substitution from
> depmod - this makes the names printed for modules in module.alias
> match the actual names of the module files.

Looks fine, thanks Bill!

(Note: this is harmless, because modprobe canonicalizes them itself when
reading the file anyway, so no change there).

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

