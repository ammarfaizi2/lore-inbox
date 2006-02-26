Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWBZTfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWBZTfU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 14:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWBZTfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 14:35:20 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:4494 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751261AbWBZTfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 14:35:18 -0500
Subject: Re: old radeon latency problem still unfixed?
From: Lee Revell <rlrevell@joe-job.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1140945232.2934.0.camel@laptopd505.fenrus.org>
References: <1140917787.24141.78.camel@mindpipe>
	 <1140945232.2934.0.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 14:35:13 -0500
Message-Id: <1140982513.24141.118.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 10:13 +0100, Arjan van de Ven wrote:
> On Sat, 2006-02-25 at 20:36 -0500, Lee Revell wrote:
> > Users report that this patch:
> > 
> > https://www.redhat.com/archives/fedora-devel-list/2004-June/msg00072.html
> > 
> > is still needed to eliminate audio underruns for Radeon users.
> > 
> > Any news on this?
> 
> well that patch is not working (it's already in the mail, it schedules
> with spinlocks ;)
> 

Understood, your response indicated that you would investigate a proper
solution.

> the other angle is that you're trading 3D performance vs audio
> performance....
> 

AFAICT it's more like trading 3D performance for having audio work at
all.  Other video drivers that were too aggressive and caused audio
dropouts (VIA) were fixed, even though there was a slight performance
cost.

Lee

