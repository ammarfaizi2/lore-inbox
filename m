Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbUCSDHo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 22:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbUCSDHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 22:07:44 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:50421 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261710AbUCSDHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 22:07:43 -0500
Subject: Re: CONFIG_PREEMPT and server workloads
From: Eric St-Laurent <ericstl34@sympatico.ca>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <s5hlllycgz3.wl@alsa2.suse.de>
References: <40591EC1.1060204@geizhals.at>
	 <20040318060358.GC29530@dualathlon.random>  <s5hlllycgz3.wl@alsa2.suse.de>
Content-Type: text/plain
Message-Id: <1079665660.7609.6.camel@orbiter>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Mar 2004 22:07:41 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 10:28, Takashi Iwai wrote:

> in my case with reiserfs, i got 0.4ms RT-latency with my test suite
> (with athlon 2200+).
> 
> there is another point to be fixed in the reiserfs journal
> transaction.  then you'll get 0.1ms RT-latency without preemption.

Are you talking about the following patch recently merged in Linus tree?

[PATCH] resierfs: scheduling latency improvements
http://linus.bkbits.net:8080/linux-2.5/cset@40571b49jtE7PzOtsXjBx65-GoDijg

I'm interested to try any patch you might have to help reduce latency
with reiserfs.


