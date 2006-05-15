Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbWEOSWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbWEOSWa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbWEOSWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:22:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13952 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965075AbWEOSW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:22:29 -0400
Date: Mon, 15 May 2006 11:24:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] x86 NUMA panic compile error
Message-Id: <20060515112456.0624d498.akpm@osdl.org>
In-Reply-To: <4468C3B8.8090502@shadowen.org>
References: <20060515005637.00b54560.akpm@osdl.org>
	<20060515140811.GA23750@shadowen.org>
	<20060515175306.GA18185@elte.hu>
	<20060515110814.11c74d70.akpm@osdl.org>
	<4468C3B8.8090502@shadowen.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> > So it is perhaps reasonable to do this panic, but only if !CONFIG_EMBEDDED? 
> > (It really is time to start renaming CONFIG_EMBEDDED to CONFIG_DONT_DO_THIS
> > or something).
> 
> How about CONFIG_EXPERIMENTAL?

Probably CONFIG_ADVANCED would be closer.
