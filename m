Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWDUMEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWDUMEl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 08:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWDUMEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 08:04:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:42983 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932068AbWDUMEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 08:04:40 -0400
From: Andi Kleen <ak@suse.de>
To: Kirill Korotaev <dev@openvz.org>
Subject: Re: [PATCH][x86_64] IPI calltraces on x86_64
Date: Fri, 21 Apr 2006 14:02:28 +0200
User-Agent: KMail/1.9.1
Cc: devel@openvz.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       xemul@openvz.org
References: <444381A9.4020400@openvz.org>
In-Reply-To: <444381A9.4020400@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604211402.29107.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 April 2006 13:53, Kirill Korotaev wrote:
> [PATCH] IPI calltraces on x86_64
>
> This patch makes x86_64 kernel to print calltraces on _all_
> CPUs on Alt-SysRq-p and NMI LOCKUP.
> This patch supplements the one made for i386
> some time ago and included in -mm tree.
> Since it proved its usefullness many times already
> we did the same patch for x86_64.

Sorry for the late answer.
I don't like the new call back. Can you change it to use the die notifier 
chain?

-Andi

