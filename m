Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285818AbRLHEkU>; Fri, 7 Dec 2001 23:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285819AbRLHEkF>; Fri, 7 Dec 2001 23:40:05 -0500
Received: from zero.tech9.net ([209.61.188.187]:12294 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S285818AbRLHEkB>;
	Fri, 7 Dec 2001 23:40:01 -0500
Subject: Re: [PATCH] Make highly niced processes run only when idle
From: Robert Love <rml@tech9.net>
To: root <r6144@263.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15377.39251.359055.873680@localhost.localdomain>
In-Reply-To: <15377.39251.359055.873680@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 07 Dec 2001 23:39:53 -0500
Message-Id: <1007786393.12110.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-12-07 at 23:38, root wrote:
> This patch makes a process with nice values >= 20 (according to
> setpriority(2)) completely stop when there are other runnable
> processes with smaller nice values.
> Try run something with `nice -n 30' (which `setpriority' to 20)

What do you think will happen when an "idle" task holds a resource or is
otherwise a producer for something a higher priority, running, task
needs?

	Robert Love

