Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVAaRHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVAaRHE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVAaRHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:07:04 -0500
Received: from [81.2.110.250] ([81.2.110.250]:10715 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261266AbVAaRGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:06:50 -0500
Subject: Re: [PATCH] add AMD Geode processor support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dan Malek <dan@embeddedalley.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <39DB0285-7030-11D9-A0FB-003065F9B7DC@embeddedalley.com>
References: <39DB0285-7030-11D9-A0FB-003065F9B7DC@embeddedalley.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1107172039.14782.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 31 Jan 2005 16:01:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-27 at 06:54, Dan Malek wrote:
> Hi Marcelo!
> 
> Here is a patch for 2.4 that adds the basic AMD Geode GX2/GX3
> and GX1/SC1200 support.  This patch updates configuration
> scripts, defconfig, and setup files.

GX2 seems no different to the older Cyrix/NS settings. GX3 a little
different.
Also you might not want to magically force settings like highmem because
you want that for multi-target kernels - Geode is a sort of odd case
where it almost makes sense but its different enough to make me dubious.


