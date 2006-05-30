Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWE3JgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWE3JgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 05:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWE3JgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 05:36:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61115 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932213AbWE3JgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 05:36:09 -0400
Date: Tue, 30 May 2006 02:40:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Amy Griffis <amy.griffis@hp.com>
Cc: linux-kernel@vger.kernel.org, john@johnmccutchan.com, rlove@rlove.org
Subject: Re: [PATCH] inotify kernel API
Message-Id: <20060530024013.5d80ba81.akpm@osdl.org>
In-Reply-To: <20060526021030.GA4936@zk3.dec.com>
References: <20060526021030.GA4936@zk3.dec.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2006 22:10:30 -0400
Amy Griffis <amy.griffis@hp.com> wrote:

>  fs/inotify.c                          |  991 +++++++++-------------------------
>  fs/inotify_user.c                     |  719 ++++++++++++++++++++++++

This patch would be much easier to review if the move-code-around part was
delivered in a separate patch from the add-new-functionality part.

