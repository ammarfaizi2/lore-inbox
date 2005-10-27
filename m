Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVJ0Nja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVJ0Nja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 09:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVJ0Nja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 09:39:30 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:12746 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750748AbVJ0Nja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 09:39:30 -0400
Date: Thu, 27 Oct 2005 06:38:59 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rajesh.shah@intel.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] export cpu_online_map
Message-Id: <20051027063859.20fcb9bb.pj@sgi.com>
In-Reply-To: <20051027023548.0471db17.akpm@osdl.org>
References: <200510260421.j9Q4LGh9014087@shell0.pdx.osdl.net>
	<20051026205038.26a1c333.pj@sgi.com>
	<20051026210803.07efba69.akpm@osdl.org>
	<20051027015504.5a20ed05.pj@sgi.com>
	<20051027023548.0471db17.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Sweet, thanks.  Perhaps we can remove cpu_online_map from UP builds soon -
> it's really wrong to have it there.

Eh ... my gut reaction is different.   Even uni-processors have
online cpus - just not very many of them (and hot unplugging one
of them is frowned on).  Why make special cases when it serves no
purpose?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
