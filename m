Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbWIOOsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbWIOOsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbWIOOsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:48:09 -0400
Received: from lixom.net ([66.141.50.11]:13698 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1751600AbWIOOsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:48:07 -0400
Date: Fri, 15 Sep 2006 09:46:38 -0500
From: Olof Johansson <olof@lixom.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: neilb@suse.de, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, christopher.leech@intel.com
Subject: Re: [PATCH 09/19] dmaengine: reduce backend address permutations
Message-ID: <20060915094638.7eded22f@localhost.localdomain>
In-Reply-To: <20060911231823.4737.95500.stgit@dwillia2-linux.ch.intel.com>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
	<20060911231823.4737.95500.stgit@dwillia2-linux.ch.intel.com>
X-Mailer: Sylpheed-Claws 2.1.1 (GTK+ 2.8.17; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 11 Sep 2006 16:18:23 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> Change the backend dma driver API to accept a 'union dmaengine_addr'.  The
> intent is to be able to support a wide range of frontend address type
> permutations without needing an equal number of function type permutations
> on the backend.

Please do the cleanup of existing code before you apply new function.
Earlier patches in this series added code that you're modifying here.
If you modify the existing code first it's less churn for everyone to
review.


Thanks,

Olof
