Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWAEPnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWAEPnf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWAEPnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:43:33 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:20474 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932129AbWAEPnL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:43:11 -0500
Subject: Re: 2.6.15-rt1-sr1: xfs mount crash
From: Daniel Walker <dwalker@mvista.com>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Vegard Lima <Vegard.Lima@hia.no>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.44L0.0601051618200.3110-100000@lifa02.phys.au.dk>
References: <Pine.LNX.4.44L0.0601051618200.3110-100000@lifa02.phys.au.dk>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 07:43:08 -0800
Message-Id: <1136475789.31011.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 16:19 +0100, Esben Nielsen wrote:

> 
> CONFIG_DEBUG_RT_LOCKING_MODE turns spinlock_t into raw_spinlock_t again as
> far as I can see. It is probably some spinlock_t which has to be a
> raw_spinlock_t for the time being.


It looks like it may still be using mutexes in one mode, but they aren't
preemptive . Or that's what it says in the menuconfig help section .
I've never used that option, honestly .


Daniel

