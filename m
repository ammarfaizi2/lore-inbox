Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030531AbWFVFq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030531AbWFVFq4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 01:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932798AbWFVFqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 01:46:55 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:52948 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932261AbWFVFqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 01:46:55 -0400
Date: Thu, 22 Jun 2006 07:46:49 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Al Boldi <a1426z@gawab.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Incorrect CPU process accounting using CONFIG_HZ=100
In-Reply-To: <200606211716.01472.a1426z@gawab.com>
Message-ID: <Pine.LNX.4.61.0606220741540.25261@yvahk01.tjqt.qr>
References: <200606211716.01472.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Setting CONFIG_HZ=100 results in incorrect CPU process accounting.
>
>This can be seen running top d.1, that shows top, itself, consuming 0ms 
>CPUtime.
>
>Will this bug have consequences for sched.c?

Works for me, somewhat.
TIME+ says 0:00.02 after 70 secs. (Ergo: top is not expensive on this CPU.)

>Thanks!

Jan Engelhardt
-- 
