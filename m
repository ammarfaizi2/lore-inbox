Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWEWUo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWEWUo2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 16:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWEWUo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 16:44:28 -0400
Received: from [212.70.35.222] ([212.70.35.222]:58891 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932194AbWEWUo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 16:44:27 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/6] statistics infrastructure
Date: Tue, 23 May 2006 23:42:03 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605232342.03639.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peschke wrote:
> Andrew Morton wrote:
> > Martin Peschke <mp3@de.ibm.com> wrote:
> >> My patch series is a proposal for a generic implementation of
> >> statistics.
> >
> > This uses debugfs for the user interface, but the
> > per-task-delay-accounting-*.patch series from Balbir creates an
> > extensible netlink-based system for passing instrumentation results back
> > to userspace.
> >
> > Can this code be converted to use those netlink interfaces, or is
> > Balbir's approach unsuitable, or hasn't it even been considered, or
> > what?
>
> Andrew,
>
> taskstats, Balbir'r approach, is too specific and doesn't work for me.
> It is by design limited to per-task data.
>
> My statistics code is not limited to per-task statistics, but allows
> exploiters to have data been accumulated and been shown for whatever
> entity they need to, may it be for tasks, for SCSI disks, per adapter, per
> queue, per interface, for a device driver, etc.

How does your work and Balbir's and CKRM relate to each other?

Is there not a way to abstract your works to provide a common statistics 
infrastructure for all?

Thanks!

--
Al

