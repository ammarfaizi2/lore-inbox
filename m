Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWJCOlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWJCOlB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 10:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWJCOlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 10:41:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56192 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932247AbWJCOlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 10:41:00 -0400
Subject: Re: BIOS THRM-Throttling and driver timings
From: Arjan van de Ven <arjan@infradead.org>
To: Keith Chew <keith.chew@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20f65d530610030729o42658bd6hcc204f8deac4a33e@mail.gmail.com>
References: <20f65d530610030729o42658bd6hcc204f8deac4a33e@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 03 Oct 2006 16:40:36 +0200
Message-Id: <1159886437.2891.532.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 03:29 +1300, Keith Chew wrote:
> Hi
> 
> We have a motherboard that has Thermal Throttling in the BIOS (which
> we cannot disable). This causes the CPU usage to go up and down when
> the CPU temperature reaches (and stays around) the Throttling
> temperature point.
> 
> What we would like to know is whether this will affect the timings in
> drivers, eg the wireless drivers we are using. What can we check in
> drivers' code that will tell us that its operations may be affected
> the throttling?
> 
> In the past few days, we noticed that some of the linux units we
> deployed freezes after deveral hours of operation, we are now trying
> to reproduce the problem in our test environment. Some insight on the
> affect of throttling will help us narrow down the search.


Hi,

in general linux should be ok with this happening. However for specific
cases... you'll need to provide more information; you're not mentioning
which drivers you are using for example. Or even which versions of the
kernel etc etc....

(also: if you actually HIT throttling, there is something very very
wrong; you're not supposed to hit that unless the fan is defective, but
never in "normal" healthy operation. If you do hit it without hardware
defects then there is most likely a fundamental airflow problem you'll
want to fix urgently)


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

