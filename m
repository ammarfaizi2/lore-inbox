Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbUCVIMk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 03:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbUCVIMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 03:12:40 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:5831 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261660AbUCVIMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 03:12:39 -0500
Date: Mon, 22 Mar 2004 03:12:44 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Olaf Hering <olh@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6-mm] defer free_initmem() if we have no /init
In-Reply-To: <20040322074929.GB15682@suse.de>
Message-ID: <Pine.LNX.4.58.0403220311420.28727@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0403220132060.28727@montezuma.fsmlabs.com>
 <20040322074929.GB15682@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Olaf Hering wrote:

>  On Mon, Mar 22, Zwane Mwaikambo wrote:
>
> > In the absence of /init and other nice boot goodies, we fall through to
> > prepare_namespace() so we shall require initmem to complete boot.
>
> Andrew, please restore the previous version of the patch. The 3 liner is
> much more obvious.

Olaf, what does the previous patch look like?
