Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWF2TiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWF2TiK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWF2TiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:38:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42733 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932333AbWF2TiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:38:08 -0400
Date: Thu, 29 Jun 2006 12:36:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] kernel/sys.c: remove unused exports
Message-Id: <20060629123608.a2a5c5c0.akpm@osdl.org>
In-Reply-To: <20060629191940.GL19712@stusta.de>
References: <20060629191940.GL19712@stusta.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 21:19:40 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> This patch removes the following unused exports:
> - EXPORT_SYMBOL:
>   - in_egroup_p
> - EXPORT_SYMBOL_GPL's:
>   - kernel_restart
>   - kernel_halt

Switch 'em to EXPORT_UNUSED_SYMBOL and I'll stop dropping your patches ;)

