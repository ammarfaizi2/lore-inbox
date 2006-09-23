Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbWIWBYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbWIWBYJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 21:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWIWBYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 21:24:09 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:9503 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S965109AbWIWBYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 21:24:06 -0400
X-IronPort-AV: i="4.09,205,1157353200"; 
   d="scan'208"; a="324498931:sNHT30664272"
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Arnd Bergmann <arnd@arndb.de>, "Luke Yang" <luke.adi@gmail.com>,
       linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
X-Message-Flag: Warning: May contain useful information
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
	<200609230218.36894.arnd@arndb.de>
	<20060922181826.3b209d1d.rdunlap@xenotime.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 22 Sep 2006 18:24:04 -0700
In-Reply-To: <20060922181826.3b209d1d.rdunlap@xenotime.net> (Randy Dunlap's message of "Fri, 22 Sep 2006 18:18:26 -0700")
Message-ID: <adad59nfk97.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Sep 2006 01:24:05.0635 (UTC) FILETIME=[F5CFCD30:01C6DEAE]
Authentication-Results: sj-dkim-6.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > > +static char *cplb_print_entry(char *buf, int type)

 > examples of acceptable interfaces?

I don't know exactly what a CPLB is, but it looks like this file is
something debugging-related.  So stick it in debugfs?

 - R.
