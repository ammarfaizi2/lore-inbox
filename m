Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUEFONL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUEFONL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 10:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUEFOMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 10:12:53 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:19972 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262380AbUEFOJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 10:09:40 -0400
Date: Thu, 6 May 2004 15:09:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Sourav Sen <souravs@india.hp.com>, Matt_Domsch@dell.com,
       matthew.e.tolentino@intel.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.6 PATCH] Exposing EFI memory map
Message-ID: <20040506150933.A17112@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@debian.org>,
	Sourav Sen <souravs@india.hp.com>, Matt_Domsch@dell.com,
	matthew.e.tolentino@intel.com, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <003801c43347$812a1590$39624c0f@india.hp.com> <20040506114414.A14543@infradead.org> <20040506115919.GZ2281@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040506115919.GZ2281@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Thu, May 06, 2004 at 12:59:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 12:59:19PM +0100, Matthew Wilcox wrote:
> It's not exactly modifiable.  I'm not sure what benefit we'd gain from
> splitting this file into dozens.

a consistant interface.  If we support gazillion random formats in sysfs
it's no gain at all over the old procfs mess.
