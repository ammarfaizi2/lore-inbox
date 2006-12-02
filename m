Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162379AbWLBAdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162379AbWLBAdF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 19:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162028AbWLBAdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 19:33:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35295 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1162379AbWLBAdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 19:33:02 -0500
Date: Fri, 1 Dec 2006 16:32:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ed Tomlinson <edt@aei.ca>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org,
       akinobu.mita@gmail.com, jgarzik@pobox.com, Matt_Domsch@dell.com
Subject: Re: 2.6.19-rc6-mm2
Message-Id: <20061201163248.f174bc0b.akpm@osdl.org>
In-Reply-To: <200612011933.22029.edt@aei.ca>
References: <20061128020246.47e481eb.akpm@osdl.org>
	<20061129201006.b7ae509f.randy.dunlap@oracle.com>
	<200611300803.30969.edt@aei.ca>
	<200612011933.22029.edt@aei.ca>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2006 19:33:21 -0500
Ed Tomlinson <edt@aei.ca> wrote:

> I booted without the video and vga settings with earlyprintk=vga and got output.  The
> kenerl was complaining about a crc error.  Checking the patch list I found:
> 
> crc32-replace-bitreverse-by-bitrev32.patch
> 
> reversing this patch fixes booting here.

Odd that you're the only person seeing this - could be a miscompile?

What was the error message, exactly?

