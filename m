Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbVKGV1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbVKGV1g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbVKGV1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:27:36 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:17621 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965093AbVKGV1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:27:35 -0500
Subject: Re: [2.6 patch] mm/: small cleanups
From: Dave Hansen <haveblue@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051107211836.GX3847@stusta.de>
References: <20051030010508.GU4180@stusta.de>
	 <1130683352.12551.15.camel@localhost>  <20051107211836.GX3847@stusta.de>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 22:27:27 +0100
Message-Id: <1131398847.7967.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 22:18 +0100, Adrian Bunk wrote:
> On Sun, Oct 30, 2005 at 03:42:32PM +0100, Dave Hansen wrote:
> > On Sun, 2005-10-30 at 02:05 +0100, Adrian Bunk wrote:
> > > This patch contains the following cleanups:
> > > - make some needlessly global functions static
> > > - vmscan.c: #if 0 the unused global function sys_set_zone_reclaim
> > 
> > If it's truly unused, why not simply kill it completely?
> 
> Updated patch below.

Looks better now.  The net removal of 27 lines makes it much easier to
sell as a cleanup. :)

-- Dave

