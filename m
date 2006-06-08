Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWFHTpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWFHTpi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 15:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWFHTpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 15:45:38 -0400
Received: from www.tglx.de ([213.239.205.147]:38631 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964869AbWFHTpi (ORCPT
	<rfc822;linux-kerneL@vger.kernel.org>);
	Thu, 8 Jun 2006 15:45:38 -0400
Subject: Re: RT exec for exercising RT kernel capabilities
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: markh@compro.net
Cc: linux-kerneL@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <448876B9.9060906@compro.net>
References: <448876B9.9060906@compro.net>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 21:46:15 +0200
Message-Id: <1149795975.5257.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

On Thu, 2006-06-08 at 15:12 -0400, Mark Hounschell wrote:
> With the ongoing work being done to rt kernel enhancements by Ingo and friends,
> I would like to offer the use of a user land test (rt-exec). The rt-exec tests
> well the deterministic real-time capabilities of a computer. Maybe it could
> useful in some way to the effort or to anyone interested in making this type of
> determination about their kernel/computer.
> 
> A README describing the rt-exec can be found at
> ftp://ftp.compro.net/public/rt-exec/README
> 
> It can be downloaded from
> ftp://ftp.compro.net/public/rt-exec/rt-exec-1.0.0.tar.bz2
> 
> Complaints, comments, or suggestions welcome.

Nice tool. 

Some remarks. You can build high resolution timer support without the
extra lib package from the HRT sourceforge site. You need a recent glibc
and  some quirks in the source. See the cyclictest program I'm using.
http://www.tglx.de/projects/misc/cyclictest/cyclictest-v0.8.tar.bz2

It would also be cute to add tests for the PI support for
pthread_mutexes.

	tglx


