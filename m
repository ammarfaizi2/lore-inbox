Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWBZJNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWBZJNz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 04:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWBZJNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 04:13:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53190 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751291AbWBZJNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 04:13:54 -0500
Subject: Re: old radeon latency problem still unfixed?
From: Arjan van de Ven <arjan@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1140917787.24141.78.camel@mindpipe>
References: <1140917787.24141.78.camel@mindpipe>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 10:13:51 +0100
Message-Id: <1140945232.2934.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-25 at 20:36 -0500, Lee Revell wrote:
> Users report that this patch:
> 
> https://www.redhat.com/archives/fedora-devel-list/2004-June/msg00072.html
> 
> is still needed to eliminate audio underruns for Radeon users.
> 
> Any news on this?

well that patch is not working (it's already in the mail, it schedules
with spinlocks ;)

the other angle is that you're trading 3D performance vs audio
performance....

