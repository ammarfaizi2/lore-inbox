Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271278AbTG2GOh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 02:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271279AbTG2GOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 02:14:37 -0400
Received: from CPE-65-29-19-166.mn.rr.com ([65.29.19.166]:15746 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S271278AbTG2GOg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 02:14:36 -0400
Subject: Re: 2.6.0-test2-mm1: Can't mount root
From: Shawn <core@enodev.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030728224756.56912a08.akpm@osdl.org>
References: <1059428584.6146.9.camel@localhost>
	 <20030728144704.49c433bc.akpm@osdl.org>
	 <1059430015.6146.15.camel@localhost>
	 <20030728150245.42f57f89.akpm@osdl.org>
	 <1059444271.4786.25.camel@localhost>
	 <20030728193633.1b2bc9d8.akpm@osdl.org> <1059456725.4781.9.camel@localhost>
	 <20030728224756.56912a08.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059459275.4781.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 29 Jul 2003 01:14:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I fingered the same, but I'll nary have the time till tomorrow eve.

patchectomy, here we come...

On Tue, 2003-07-29 at 00:47, Andrew Morton wrote:
> Shawn <core@enodev.com> wrote:
> >
> >  > What was the most recent kernel which works?
> > 
> >  Looks like vanilla -test2 passes muster. Boots, etc.
> 
> drat, so I have a dud patch.
> 
> The simplest but boringest way to find it is a binary search through the
> patches.  The `series' file holds the patching order.  it'd be painful
> without using the scripts though.
> 
> You could try randomly reverting nforce2-acpi-fixes.patch.

