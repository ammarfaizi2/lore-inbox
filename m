Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTFDIAT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 04:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbTFDIAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 04:00:18 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:19185 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263131AbTFDIAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 04:00:18 -0400
Date: Wed, 4 Jun 2003 01:14:13 -0700
From: Andrew Morton <akpm@digeo.com>
To: Vojtech Pavlik <vojtech@ucw.cz>
Cc: linux-yoann@ifrance.com, linux-kernel@vger.kernel.org, vojtech@suse.cz,
       acahalan@cs.uml.edu
Subject: Re: another must-fix: major PS/2 mouse problem
Message-Id: <20030604011413.16787964.akpm@digeo.com>
In-Reply-To: <20030604100017.A5475@ucw.cz>
References: <1054431962.22103.744.camel@cube>
	<3EDD87FD.6020307@ifrance.com>
	<20030603232155.1488c02f.akpm@digeo.com>
	<20030604094737.C5345@ucw.cz>
	<20030604005302.41f3b0b8.akpm@digeo.com>
	<20030604100017.A5475@ucw.cz>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jun 2003 08:13:47.0171 (UTC) FILETIME=[38F44730:01C32A71]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@ucw.cz> wrote:
>
> > Has this problem been observed in 2.4 kernels?
> 
>  No, since 2.4 doesn't have the re-sync code in the mouse driver which is
>  triggering in this case. But problems with the machine being flooded
>  with interrupts from the NIC so hard that it actually cannot do anything
>  are quite common.

So is the resync code doing more good than harm?

