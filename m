Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbUDKUja (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 16:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbUDKUja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 16:39:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:8857 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262470AbUDKUj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 16:39:29 -0400
Date: Sun, 11 Apr 2004 13:38:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: List of oversized inlines
Message-Id: <20040411133855.31022616.akpm@osdl.org>
In-Reply-To: <200404111951.34734.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200404111905.49443.vda@port.imtp.ilyichevsk.odessa.ua>
	<20040411163255.GB6248@waste.org>
	<200404111951.34734.vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
>
> Basically, you:
> 
>  * untar linux tree into tree/, 
>  * make allyesconfig

You should disable at least CONFIG_DEBUG_SPINLOCK, CONFIG_DEBUG_PAGEALLOC and
CONFIG_DEBUG_SPINLOCK_SLEEP.
