Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265292AbUFBAIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265292AbUFBAIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 20:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbUFBAIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 20:08:36 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:12532 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265292AbUFBAIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 20:08:32 -0400
Date: Tue, 1 Jun 2004 20:09:51 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
In-Reply-To: <40BC9EF7.4060502@shadowconnect.com>
Message-ID: <Pine.LNX.4.58.0406011228130.1794@montezuma.fsmlabs.com>
References: <40BC788A.3020103@shadowconnect.com> <20040601142122.GA7537@havoc.gtf.org>
 <40BC9EF7.4060502@shadowconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2004, Markus Lidel wrote:

> > probably too large an area to be remapping.  Try remapping only the
> > memory area needed, and not the entire area.
>
> Is there a way, to increase the size, which could be remapped, or is
> there a way, to find out what is the maximum size which could be remapped?
>
> Thank you very much for the fast answer!

You could try a 4G/4G enabled kernel, /proc/meminfo tells you how much
vmalloc (ioremap) space there is too.
