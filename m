Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTDPWWM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 18:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTDPWWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 18:22:12 -0400
Received: from [12.47.58.203] ([12.47.58.203]:49484 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261807AbTDPWWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 18:22:11 -0400
Date: Wed, 16 Apr 2003 15:32:59 -0700
From: Andrew Morton <akpm@digeo.com>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, george@mvista.com,
       James.Bottomley@SteelEye.com, shemminger@osdl.org, alex@ssi.bg
Subject: Re: [PATCH] linux-2.5.67_lost-tick-fix_A2
Message-Id: <20030416153259.6f99bb4e.akpm@digeo.com>
In-Reply-To: <1050530545.1077.120.camel@w-jstultz2.beaverton.ibm.com>
References: <1050530545.1077.120.camel@w-jstultz2.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Apr 2003 22:34:00.0781 (UTC) FILETIME=[46D267D0:01C30468]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> wrote:
>
> 	This patch fixes a race in the timer_interrupt code caused by
> detect_lost_tick().

Does this also fix the problem which Alex identified?

