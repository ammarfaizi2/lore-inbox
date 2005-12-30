Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbVL3DmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbVL3DmN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 22:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbVL3DmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 22:42:13 -0500
Received: from waste.org ([64.81.244.121]:61418 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750850AbVL3DmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 22:42:13 -0500
Date: Thu, 29 Dec 2005 21:38:03 -0600
From: Matt Mackall <mpm@selenic.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make sysenter support optional
Message-ID: <20051230033803.GG3356@waste.org>
References: <20051228212402.GX3356@waste.org> <a36005b50512281407x74415958tb0fa2b52f4dd7988@mail.gmail.com> <43B30E19.6080207@redhat.com> <20051229195641.GB3356@waste.org> <a36005b50512291901l6a5acb77ha17d3552ea9c9fd9@mail.gmail.com> <43B4A3CA.4060406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B4A3CA.4060406@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 07:04:42PM -0800, Ulrich Drepper wrote:
> > It's under CONFIG_EMBEDDED. Think uclibc. Think systems without
> > interactive shells.
> 
> Interactive or not has absolutely nothing to do with this.

Ok, let me be explicit: think systems with absolutely no facility for
recording or displaying a backtrace.

> And other
> libcs have the same issues wrt to backtraces.

As far as I'm aware, uclibc has no vdso support, so it might as well
not exist for systems using it.

-- 
Mathematics is the supreme nostalgia of our time.
