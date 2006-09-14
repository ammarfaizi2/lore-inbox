Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWINVi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWINVi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWINVi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:38:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37592 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751123AbWINViX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:38:23 -0400
Date: Thu, 14 Sep 2006 14:38:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Orlov <bugfixer@list.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [PATCH 2.6.18-rc6-mm1 0/2] cpufreq: make it harder for cpu to
 leave "hot" mode
Message-Id: <20060914143803.493c5bf0.akpm@osdl.org>
In-Reply-To: <20060912032924.GA3677@nickolas.homeunix.com>
References: <20060912032924.GA3677@nickolas.homeunix.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2006 23:29:24 -0400
Nick Orlov <bugfixer@list.ru> wrote:

> I was playing with ondemand cpufreq governor (gotta save on electricity
> bills one day :) ) and I've noticed that gameplay become somewhat sluggish.
> Especially noticeble in something cpu-power demanding, like quake4.
> Quick look at stats/trans_table confirmed that CPU goes out of "hot" mode
> way too often.

I won't apply any of this in view of your ongoing discussion with
Venkatesh, but thanks for the ongoing support and help - cpufreq is, shall
we say, a rich source of future kernel improvements.

Next time you prepare a patch series please ensure that it uses a different
Subject: for each patch, as per
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt, section 2.


