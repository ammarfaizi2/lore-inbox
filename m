Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267479AbUBTFaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 00:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267598AbUBTFaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 00:30:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:38340 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267479AbUBTFaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 00:30:17 -0500
Date: Thu, 19 Feb 2004 21:30:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: thockin@sun.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: report NGROUPS_MAX via a sysctl (read-only)
Message-Id: <20040219213028.42835364.akpm@osdl.org>
In-Reply-To: <20040220023927.GN9155@sun.com>
References: <20040220023927.GN9155@sun.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin <thockin@sun.com> wrote:
>
>  Attached is a simple patch to expose NGROUPS_MAX via sysctl.

Why does userspace actually care?  You try to do an oversized setgroups(),
so you get an error?

And why does NGROUPS_MAX still exist, come to that?  AFAICT the only thing
it does is to prevent users from being able to allocate too much kernel
memory??

