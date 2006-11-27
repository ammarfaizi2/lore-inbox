Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755823AbWK0BjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823AbWK0BjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 20:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755829AbWK0BjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 20:39:09 -0500
Received: from outbound0.mx.meer.net ([209.157.153.23]:35599 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S1755823AbWK0BjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 20:39:07 -0500
Subject: Re: 2.6.19-rc6-mm1 -- sched-improve-migration-accuracy.patch slows
	boot
From: Don Mullis <dwm@meer.net>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <1164522263.5808.12.camel@Homer.simpson.net>
References: <20061123021703.8550e37e.akpm@osdl.org>
	 <1164484124.2894.50.camel@localhost.localdomain>
	 <1164522263.5808.12.camel@Homer.simpson.net>
Content-Type: text/plain
Date: Sun, 26 Nov 2006 17:38:29 -0800
Message-Id: <1164591509.2894.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This must be a bisection false positive.  The patch in question is
> essentially a no-op for a UP kernel.

Testing alternately with 
	1) all -mm1 patches applied, and 
	2) all except sched-improve-migration-accuracy*.path applied,
confirms the misbehavior.


