Return-Path: <linux-kernel-owner+w=401wt.eu-S964789AbWLTCes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWLTCes (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 21:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWLTCes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 21:34:48 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:48942 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964789AbWLTCer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 21:34:47 -0500
Date: Tue, 19 Dec 2006 18:35:39 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Brownell <david-b@pacbell.net>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: Changes to sysfs PM layer break userspace
Message-Id: <20061219183539.70bd3e9e.randy.dunlap@oracle.com>
In-Reply-To: <20061219181524.c15c02af.akpm@osdl.org>
References: <20061219185223.GA13256@srcf.ucam.org>
	<1166559785.3365.1276.camel@laptopd505.fenrus.org>
	<20061219203251.GA14648@srcf.ucam.org>
	<200612191334.49760.david-b@pacbell.net>
	<20061219181524.c15c02af.akpm@osdl.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 18:15:24 -0800 Andrew Morton wrote:

> On Tue, 19 Dec 2006 13:34:49 -0800
> David Brownell <david-b@pacbell.net> wrote:
> 
> > Documentation/feature-removal-schedule.txt has warned about this since
> > August
> 
> Nobody reads that.

Ugh, I read it.

> Please, wherever possible, put a nice printk("this is going away") in the code
> when planning these things.

Can notices go in both places, or is in the source code (printk)
now the preferred way?

I think that we can point people to Doc/feature-removal-schedule.txt
easier (and more effectively) than we can source code (or noisy kernel
logs).

---
~Randy
