Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270497AbTG2Fro (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 01:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271269AbTG2Fro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 01:47:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:15326 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270497AbTG2Frn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 01:47:43 -0400
Date: Mon, 28 Jul 2003 22:47:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shawn <core@enodev.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm1: Can't mount root
Message-Id: <20030728224756.56912a08.akpm@osdl.org>
In-Reply-To: <1059456725.4781.9.camel@localhost>
References: <1059428584.6146.9.camel@localhost>
	<20030728144704.49c433bc.akpm@osdl.org>
	<1059430015.6146.15.camel@localhost>
	<20030728150245.42f57f89.akpm@osdl.org>
	<1059444271.4786.25.camel@localhost>
	<20030728193633.1b2bc9d8.akpm@osdl.org>
	<1059456725.4781.9.camel@localhost>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn <core@enodev.com> wrote:
>
>  > What was the most recent kernel which works?
> 
>  Looks like vanilla -test2 passes muster. Boots, etc.

drat, so I have a dud patch.

The simplest but boringest way to find it is a binary search through the
patches.  The `series' file holds the patching order.  it'd be painful
without using the scripts though.

You could try randomly reverting nforce2-acpi-fixes.patch.
