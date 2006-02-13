Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbWBMBXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWBMBXv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 20:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbWBMBXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 20:23:51 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:46297 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751543AbWBMBXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 20:23:51 -0500
Date: Mon, 13 Feb 2006 02:23:37 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Lee Revell <rlrevell@joe-job.com>
cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] hrtimer: remove data field
In-Reply-To: <1139793512.2739.37.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0602130221310.30994@scrub.home>
References: <Pine.LNX.4.61.0602130211150.23843@scrub.home>
 <1139793512.2739.37.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 12 Feb 2006, Lee Revell wrote:

> On Mon, 2006-02-13 at 02:11 +0100, Roman Zippel wrote:
> > Remove the it_real_value from /proc/*/stat, during 1.2.x was the last
> > time it returned useful data (as it was directly maintained by the
> > scheduler), now it's only a waste of time to calculate it.
> 
> Won't this break apps that parse this file?

No, it's now simply set to zero.

bye, Roman
