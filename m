Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270759AbTHOSmn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270767AbTHOSko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:40:44 -0400
Received: from 64.221.211.204.ptr.us.xo.net ([64.221.211.204]:33427 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S270763AbTHOSkM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:40:12 -0400
Subject: Re: Centrino support
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m2wude3i2y.fsf@tnuctip.rychter.com>
References: <m2wude3i2y.fsf@tnuctip.rychter.com>
Content-Type: text/plain
Message-Id: <1060972810.29086.8.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Aug 2003 11:40:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-15 at 11:13, Jan Rychter wrote:

> Well, that was almost 5 months ago. So I figured I'd ask if there's any
> progress -- so far the built-in wireless in my notebook still doesn't
> work with Linux and the machine is monstrously power-hungry because
> Linux doesn't scale the CPU frequency.

Intel shows no inclination to release Centrino wireless drivers for
Linux.  There have been vague insinuations that this is due to excessive
software controllability, but no public explanations have been given,
beyond "we're not doing it at this moment".

If you want built-in wireless in the nearish term, you'll have to get a
supported MiniPCI card and replace your Centrino card.

As far as CPU is concerned, if you're using recent 2.5 or 2.6 kernels,
there's Pentium M support in cpufreq.  Jeremy Fitzhardinge has written a
userspace daemon that varies the Pentium M CPU frequency in response to
load.

	<b

