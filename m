Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVCOOlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVCOOlG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVCOOlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:41:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1470 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261280AbVCOOlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:41:01 -0500
Date: Tue, 15 Mar 2005 09:40:51 -0500
From: Dave Jones <davej@redhat.com>
To: jerome lacoste <jerome.lacoste@gmail.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: enabling IOAPIC on C3 processor? (how to investigate hangs without nmi watchdog)
Message-ID: <20050315144051.GC27654@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	jerome lacoste <jerome.lacoste@gmail.com>,
	Mikael Pettersson <mikpe@csd.uu.se>,
	lkml <linux-kernel@vger.kernel.org>
References: <5a2cf1f6050315040956a512a6@mail.gmail.com> <16950.54895.527127.21123@alkaid.it.uu.se> <5a2cf1f605031504527979cef4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a2cf1f605031504527979cef4@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 01:52:47PM +0100, jerome lacoste wrote:

 > Do I have any alternative to investigate this hang or should I just
 > give up and smash my board?

If you have the longhaul cpufreq driver enabled, turn it off.
It's currently broken for some reason, and I've not had time to
figure out why.

		Dave

