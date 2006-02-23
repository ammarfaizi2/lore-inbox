Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWBWUUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWBWUUG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 15:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWBWUUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 15:20:06 -0500
Received: from kanga.kvack.org ([66.96.29.28]:34952 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932087AbWBWUUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 15:20:04 -0500
Date: Thu, 23 Feb 2006 15:15:10 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Gautam H Thaker <gthaker@atl.lmco.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: ~5x greater CPU load for a networked application when using 2.6.15-rt15-smp vs. 2.6.12-1.1390_FC4
Message-ID: <20060223201510.GA30329@kvack.org>
References: <43FE134C.6070600@atl.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FE134C.6070600@atl.lmco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 02:55:56PM -0500, Gautam H Thaker wrote:
> It has been documented before (and accepted) that this patch turns Linux into
> a RT kernel but considerably slows down the code paths, esp. thru the I/O
> subsystem. I want to provide some additional measurements and seek opinions
> of if it might ever be possible to improve on this situation.

32 bit kernel or 64 bit kernel?  What about profiling the system with 
oprofile?

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
