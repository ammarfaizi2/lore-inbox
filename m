Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVCXWVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVCXWVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 17:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVCXWVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 17:21:39 -0500
Received: from fire.osdl.org ([65.172.181.4]:15243 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261170AbVCXWVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 17:21:35 -0500
Date: Thu, 24 Mar 2005 14:21:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: cliff white <cliffw@osdl.org>
Cc: airlied@linux.ie, davej@redhat.com, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: drm bugs hopefully fixed but there might still be one..
Message-Id: <20050324142131.2646c4fd.akpm@osdl.org>
In-Reply-To: <20050324135851.388d1b4e@es175>
References: <Pine.LNX.4.58.0503241015190.7647@skynet>
	<20050324135851.388d1b4e@es175>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cliff white <cliffw@osdl.org> wrote:
>
> Okay, i have a iBook G4, with radeon, with 2.6.12-rc1-mm2, i'm getting the following OOPS
> on boot. 

Please try reverting agp-make-some-code-static.patch (Dunno why that would
fix an oops, but apparently it does).

