Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbWFNQQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWFNQQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 12:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbWFNQQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 12:16:29 -0400
Received: from xenotime.net ([66.160.160.81]:54493 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965024AbWFNQQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 12:16:29 -0400
Date: Wed, 14 Jun 2006 09:19:13 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] binfmt: turn MAX_ARG_PAGES into a sysctl tunable
Message-Id: <20060614091913.3c7adb83.rdunlap@xenotime.net>
In-Reply-To: <4490310C.9010601@linux.intel.com>
References: <1150297122.31522.54.camel@lappy>
	<4490310C.9010601@linux.intel.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2006 08:53:48 -0700 Arjan van de Ven wrote:

> Peter Zijlstra wrote:
> > From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > 
> > Some folks find 128KB of env+arg space too little. Solaris provides them with
> > 1MB. Manually changing MAX_ARG_PAGES worked for them so far, however they
> > would like to run the supported vendor kernel.
> 
> then this patch should go to the vendors maybe ;)

Wouldn't a mainline merge get it to the vendors?
or put another way, why would the distro vendors want it
if it's not in mainline?

> > In the interrest of not penalizing everybody with the overhead of just
> > setting it larger, provide a sysctl to change it.
> > 
> 
> 
> why not go all the way and make it truely dynamic ?

---
~Randy
