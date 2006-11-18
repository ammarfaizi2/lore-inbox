Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754437AbWKRLpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbWKRLpM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 06:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756296AbWKRLpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 06:45:12 -0500
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:47571 "EHLO
	aa012msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1754437AbWKRLpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 06:45:10 -0500
Date: Sat, 18 Nov 2006 12:43:49 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: sleeping functions called in invalid context during resume
Message-ID: <20061118124349.16743124@localhost>
In-Reply-To: <20061117083008.7758149a@localhost.localdomain>
References: <20061114223002.10c231bd@localhost.localdomain>
	<20061116212158.0ef99842@localhost.localdomain>
	<20061117065202.GA11877@elte.hu>
	<200611171646.05860.rjw@sisk.pl>
	<20061117083008.7758149a@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 08:30:08 -0800
Stephen Hemminger <shemminger@osdl.org> wrote:

> > > > APIC error on CPU0: 00(00)
> > > > 
> > > > Is it an ACPI problem?
> > > 
> > > a 00 error code? Never seen that ... How frequently does it happen?
> > 
> > On my x86-64 boxes the "APIC error on CPU0" message appears on every resume,
> > but it doesn't seem to be related to any visible problems.
> > 
> > It's been there forever, AFAICT.
> 
> Yes, it is there on every resume.

Here too... so it's common on x86_64   ;)


	$ dmesg | grep Suspending | wc -l
	9

	$ dmesg | grep "APIC err" | wc -l
	9

-- 
	Paolo Ornati
	Linux 2.6.19-rc4-g2de6c39f on x86_64
