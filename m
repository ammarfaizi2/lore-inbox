Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268805AbUIHE24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268805AbUIHE24 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 00:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268864AbUIHE2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 00:28:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3988 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268182AbUIHE2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 00:28:44 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: mita akinobu <amgta@yacht.ocn.ne.jp>
Subject: Re: [PATCH] ia64: fix show_mem() for discontig machines
Date: Tue, 7 Sep 2004 21:28:34 -0700
User-Agent: KMail/1.7
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       tony.luck@intel.com
References: <200409060132.03951.amgta@yacht.ocn.ne.jp>
In-Reply-To: <200409060132.03951.amgta@yacht.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409072128.34693.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, September 5, 2004 9:32 am, mita akinobu wrote:
> Hello,
>
> On multi-node ia64 system, SysRq-M seems to dump wrong memory info.
> (Since I don't have such a large machine, I don't confirm it)
> It should reset counters every iteration each node in show_mem().

This looks good, though the bug sounds familiar.  Tony, care to apply?

Thanks,
Jesse
