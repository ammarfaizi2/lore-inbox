Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWCLFGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWCLFGP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 00:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWCLFGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 00:06:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27799 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751383AbWCLFGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 00:06:14 -0500
Date: Sat, 11 Mar 2006 21:03:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Krzysztof Oledzki <olel@ans.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More than 8 CPUs detected and CONFIG_X86_PC cannot handle it on
 2.6.16-rc6
Message-Id: <20060311210353.7eccb6ed.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603120256480.14567@bizon.gios.gov.pl>
References: <Pine.LNX.4.64.0603120256480.14567@bizon.gios.gov.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Oledzki <olel@ans.pl> wrote:
>
> After upgrading to 2.6.16-rc6 I noticed this strange message:
> 
>  More than 8 CPUs detected and CONFIG_X86_PC cannot handle it.
>  Use CONFIG_X86_GENERICARCH or CONFIG_X86_BIGSMP.
>
> This is a Dell PowerEdge SC1425 with two P4 Xeons with HT enabled (so with 
>  totoal of 4 logical CPUs).

Please send full dmesg output for the failing kernel, thanks.

Which is the most-recently-tested kernel which behaved correctly?
