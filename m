Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVC2LVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVC2LVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 06:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVC2LVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 06:21:12 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:3028 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262177AbVC2LVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 06:21:09 -0500
Message-ID: <42493B88.A481AB1F@tv-sign.ru>
Date: Tue, 29 Mar 2005 15:27:04 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/5] timers: description
References: <200503261952.j2QJq1g27569@unix-os.sc.intel.com> <Pine.LNX.4.58.0503281111220.26639@server.graphe.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
>
> On Sat, 26 Mar 2005, Chen, Kenneth W wrote:
>
> > I changed schedule_timeout() to call the new del_timer_sync instead of
> > currently del_singleshot_timer_sync in attempt to stress these set of
> > patches a bit more and I just observed a kernel hang.
> >
> > The symptom starts with lost network connectivity.  It looks like the
> > entire ethernet connections were gone, followed by blank screen on the
> > console.  I'm not sure whether it is a hard or soft hang, but system
> > is inaccessible (blank screen and no network connection). I'm forced
> > to do a reboot when that happens.
>
> Same problems here with occasional hangs w/o changes to schedule_timeout.

Bad. You are runnning 2.6.12-rc1-mm1 ?

Oleg.
