Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264238AbUGHRKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUGHRKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 13:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbUGHRKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 13:10:20 -0400
Received: from webmail.sub.ru ([213.247.139.22]:23826 "HELO techno.sub.ru")
	by vger.kernel.org with SMTP id S264238AbUGHRKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 13:10:16 -0400
Subject: Re: [ck] Re: [PATCH] Autoregulate swappiness & inactivation
From: Mikhail Ramendik <mr@ramendik.ru>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       nigelenki@comcast.net, linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <40ECF278.7070606@yahoo.com.au>
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net>
	 <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org>
	 <cone.1089268800.781084.4554.502@pc.kolivas.org>
	 <40ECF278.7070606@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1089306601.2753.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-6aspMR) 
Date: Thu, 08 Jul 2004 21:10:01 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Secondly, can you please not mess with the exported sysctl. If you
> think your "autoswappiness" calculation is better than the current
> swappiness one, just completely replace it. Bonus points if you can
> retain the swappiness knob in some capacity.

I as a user of -ck *strongly* disagree with this proposal. I want to be
able to try both manual and automatic setting, without recompiling the
kernel.

If you really must avoid another named exported sysctl, I suggest making
a "reserved" swappiness value, like 255, that would mean
"auto-regulate".

Yours, Mikhail Ramendik



