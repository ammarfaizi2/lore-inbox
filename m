Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263233AbTDCSFi 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 13:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263261AbTDCSFi 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 13:05:38 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:17935
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263233AbTDCSFe 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 13:05:34 -0500
Subject: Re: fairsched + O(1) process scheduler
From: Robert Love <rml@tech9.net>
To: Corey Minyard <minyard@acm.org>
Cc: Antonio Vargas <wind@cocodriloo.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3E8C6C1E.8080901@acm.org>
References: <20030401125159.GA8005@wind.cocodriloo.com>
	 <20030401164126.GA993@holomorphy.com>
	 <20030401221927.GA8904@wind.cocodriloo.com>
	 <20030402124643.GA13168@wind.cocodriloo.com>
	 <20030402163512.GC993@holomorphy.com>
	 <20030402213629.GB13168@wind.cocodriloo.com>
	 <1049319300.2872.21.camel@localhost>
	 <20030402220734.GC13168@wind.cocodriloo.com>
	 <1049321427.2872.25.camel@localhost>  <3E8C6C1E.8080901@acm.org>
Content-Type: text/plain
Organization: 
Message-Id: <1049393821.1659.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 03 Apr 2003 13:17:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-03 at 12:15, Corey Minyard wrote:

> I believe this is true if the data is aligned.  I don't think it's
> true for unaligned access on an x86.

Yes, this is true.  Sorry for not mentioning.

Unless Antonio plays games with pointers and types, though, all his
accesses should be aligned.

	Robert Love

