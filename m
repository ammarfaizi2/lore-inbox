Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264954AbUI0NMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUI0NMo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 09:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUI0NMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 09:12:43 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:18318 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264953AbUI0NMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 09:12:34 -0400
Message-ID: <35fb2e590409270612524c5fb9@mail.gmail.com>
Date: Mon, 27 Sep 2004 14:12:26 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Thomas Habets <thomas@habets.pp.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040927125441.GG3934@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200409230123.30858.thomas@habets.pp.se>
	 <20040923234520.GA7303@pclin040.win.tue.nl>
	 <1096031971.9791.26.camel@localhost.localdomain>
	 <200409242158.40054.thomas@habets.pp.se>
	 <1096060549.10797.10.camel@localhost.localdomain>
	 <20040927104120.GA30364@logos.cnet>
	 <20040927125441.GG3934@marowsky-bree.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Just out of interest then...suppose we've got a loopback swap device
and that we can extend this by creating a new file or extending
somehow the existing one.

What would be wrong with having the page reclaim algorithms use one of
the low memory watermarks as a trigger to call in to userspace to
extend the swap available if possible? This is probably what Microsoft
et al do with their "Windows is extending your virtual memory, yada
yada blah blah". Comments? Already done?

Jon.
