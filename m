Return-Path: <linux-kernel-owner+willy=40w.ods.org-S277808AbUKBAln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S277808AbUKBAln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 19:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S384891AbUKBAOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 19:14:17 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:41653 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S291592AbUKBAHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 19:07:15 -0500
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200411011540.25175.vda@port.imtp.ilyichevsk.odessa.ua>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
	 <20041031201500.GA4498@thunk.org>
	 <1099308472.18809.60.camel@localhost.localdomain>
	 <200411011540.25175.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099350248.18809.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 01 Nov 2004 23:04:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-01 at 13:40, Denis Vlasenko wrote:
> This assumes that 'needed' functions are close together.
> This can be easily not the case, so you end up using only
> a fraction of fetched page's content.

And gprof will help you sort that out, along with -ffunction-sections
you can do pretty fine grained tidying


