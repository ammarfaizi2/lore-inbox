Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbTLJVvl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 16:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbTLJVvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 16:51:00 -0500
Received: from mail45-s.fg.online.no ([148.122.161.45]:56304 "EHLO
	mail45.fg.online.no") by vger.kernel.org with ESMTP id S264127AbTLJVt5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 16:49:57 -0500
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Witukind <witukind@nsbm.kicks-ass.org>, linux-kernel@vger.kernel.org
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
References: <200312081536.26022.andrew@walrond.org>
	<20031208154256.GV19856@holomorphy.com>
	<3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com>
	<20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
	<20031209075619.GA1698@kroah.com> <1070960433.869.77.camel@nomade>
	<20031209090815.GA2681@kroah.com>
	<buoiskqfivq.fsf@mcspd15.ucom.lsi.nec.co.jp> <yw1xd6ayib3f.fsf@kth.se>
	<20031210202354.7a3c429a.witukind@nsbm.kicks-ass.org>
	<yw1xd6aw4ge3.fsf@kth.se>
	<20031210212209.7fce7dae.witukind@nsbm.kicks-ass.org>
	<3FD78645.9090300@wmich.edu>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 10 Dec 2003 22:49:45 +0100
In-Reply-To: <3FD78645.9090300@wmich.edu> (Ed Sweetman's message of "Wed, 10
 Dec 2003 15:47:01 -0500")
Message-ID: <yw1x3cbs2vie.fsf@kth.se>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman <ed.sweetman@wmich.edu> writes:

> the biggest advantage from modules is the ability to enable/disable
> devices with different initialization configurations without
> rebooting, including the use of devices that aren't present during
> boot or may be added to a system that cant be put down to
> reboot. Embedded systems usually do not change, that's just part of
> being embedded, modules dont really make sense there unless things
> like filesystems and non-device modules never get used at the same
> time and memory is limited such that 100KB actually matters.

An embedded system could still have USB or something like that.  Many
PDAs do have pluggable hardware modules.

-- 
Måns Rullgård
mru@kth.se
