Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUHSQhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUHSQhy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 12:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUHSQhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 12:37:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:8686 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266519AbUHSQhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 12:37:53 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: davidm@hpl.hp.com
Subject: Re: kernbench on 512p
Date: Thu, 19 Aug 2004 12:37:16 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408191216.33667.jbarnes@engr.sgi.com> <16676.54657.220755.148837@napali.hpl.hp.com>
In-Reply-To: <16676.54657.220755.148837@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408191237.16959.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 19, 2004 12:29 pm, David Mosberger wrote:
> >>>>> On Thu, 19 Aug 2004 12:16:33 -0400, Jesse Barnes
> >>>>> <jbarnes@engr.sgi.com> said:
>
>   Jesse> It would be nice if the patch to show which lock is contended
>   Jesse> got included.
>
> Why not use q-syscollect?  It will show you the caller of
> ia64_spinlock_contention, which is often just as good (or better ;-).

Because it requires guile and guile SLIB, which I've never been able to setup 
properly on a RHEL3 based distro.  Care to rewrite the tools in C or 
something? ;)

Jesse
