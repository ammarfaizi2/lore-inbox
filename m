Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbUCZBHu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 20:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263884AbUCZAba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:31:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:3798 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263862AbUCZALz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:11:55 -0500
Date: Thu, 25 Mar 2004 16:14:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/22] /dev/random: Cleanup sleep logic
Message-Id: <20040325161404.3bc99335.akpm@osdl.org>
In-Reply-To: <3.524465763@selenic.com>
References: <2.524465763@selenic.com>
	<3.524465763@selenic.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> Cleanup /dev/random sleep logic
> 
> Original code checked in output pool rather than input pool for wakeup

So what is the rationale for switching it over to the primary pool?
