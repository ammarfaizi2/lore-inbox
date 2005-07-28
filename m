Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVG1XOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVG1XOx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 19:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVG1XOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 19:14:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1218 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261901AbVG1XOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 19:14:52 -0400
Date: Thu, 28 Jul 2005 16:13:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: george@mvista.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watch dog notify patch
Message-Id: <20050728161341.15bf9625.akpm@osdl.org>
In-Reply-To: <42E940BE.3020908@mvista.com>
References: <42E940BE.3020908@mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger <george@mvista.com> wrote:
>
> 	This patch adds a notify to the nmi watchdog to notify that
>  	the system is about to be taken down by the watchdog.  If the
>  	notify is handled with a NOTIFY_STOP return, the system is
>  	given a new lease on life.

It looks sensible, but as there aren't actually any in-kernel uses for this
I'd have thought it would be better for it to live out-of-tree?
