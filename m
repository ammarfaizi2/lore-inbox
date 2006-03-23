Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWCWShz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWCWShz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbWCWShz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:37:55 -0500
Received: from ns1.suse.de ([195.135.220.2]:20382 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932526AbWCWShy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:37:54 -0500
From: Andi Kleen <ak@suse.de>
To: Jon Mason <jdmason@us.ibm.com>
Subject: Re: [PATCH 3/3] x86-64: Calgary IOMMU - hook it in
Date: Thu, 23 Mar 2006 18:48:18 +0100
User-Agent: KMail/1.9.1
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
References: <20060320084848.GA21729@granada.merseine.nu> <200603231736.44223.ak@suse.de> <20060323173047.GA30099@us.ibm.com>
In-Reply-To: <20060323173047.GA30099@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603231848.19041.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 March 2006 18:30, Jon Mason wrote:

> We have a recent modification to this chunk which does both generic and
> em64t.  Since IBM only ships this chip on em64t systems, have the option
> on amd64 seems wrong.

Please read again what I wrote.

> Because we need to know the size of the translation tables early, so
> that we can alloc them from bootmem.

But __setup is parsed during the bootmem phase too. early arguments are only
needed for things called by setup_arch

-Andi
 
