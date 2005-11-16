Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030524AbVKPWFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030524AbVKPWFl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030525AbVKPWFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:05:40 -0500
Received: from mgrava.tizianodinca.com ([195.47.199.19]:29622 "EHLO
	mail2.rhx.it") by vger.kernel.org with ESMTP id S1030524AbVKPWFj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:05:39 -0500
Date: Wed, 16 Nov 2005 23:05:37 +0100
From: Michele Baldessari <michele@pupazzo.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS - 2.6.14.2 | 2.6.15-rc1-git4 - qla2xxx
Message-ID: <20051116220537.GA24359@michele.pupazzo.org>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	linux-kernel@vger.kernel.org
References: <20051116193608.GA8500@michele.pupazzo.org> <1132170157.27215.63.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1132170157.27215.63.camel@mindpipe>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> On Wed, 2005-11-16 at 20:36 +0100, Michele Baldessari wrote:
> > Hi,
> > 
> > As per subject I get an OOPS on bootup with qla2xx cards using 2.6.14.2
> > or 2.6.15-rc1-git4. Description follows:
> 
> This is not an Oops it's a soft lockup.  It means some program ran in
> the kernel for a long time without rescheduling which is considered a
> bug.

Ah I see, thanks for the correction ;)
 
Given it didn't happen on 2.6.13.4 I thought I'd post about it, still
worth fixing IMO.

--
Michele
