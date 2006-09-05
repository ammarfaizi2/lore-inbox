Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965190AbWIEHFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbWIEHFW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 03:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbWIEHFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 03:05:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27856 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965190AbWIEHFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 03:05:21 -0400
Date: Tue, 5 Sep 2006 00:05:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc5-mm1 unusual IRQ number for VIA device
Message-Id: <20060905000515.c8b38fe9.akpm@osdl.org>
In-Reply-To: <44FC459D.3040700@bellsouth.net>
References: <44FC2F7C.6040301@bellsouth.net>
	<44FC459D.3040700@bellsouth.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2006 10:26:21 -0500
Jay Cliburn <jacliburn@bellsouth.net> wrote:

> Jay Cliburn wrote:
> > Running 2.6.18-rc5.mm1 on an Asus M2V mainboard with dual-core Athlon 
> > cpu, the onboard audio device gets assigned and IRQ of 8410.  Under 
> > 2.6.18-rc4-mm3, the same device gets assigned IRQ 17.  Is this a way to 
> > get around this?
> 
> What I meant to ask is:  Is there a way to get around this?
> 

MSI is rather busted and has been redone.  Disabling CONFIG_MSI
may well help.
