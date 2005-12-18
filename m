Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbVLRIQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVLRIQk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 03:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbVLRIQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 03:16:40 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:59609 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932477AbVLRIQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 03:16:39 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: 2.6.15-rc5-mm3
Date: Sun, 18 Dec 2005 19:16:47 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <276aq1pc2us3np77rd8p6gvifbdj4nf2vd@4ax.com>
References: <20051214234016.0112a86e.akpm@osdl.org>
In-Reply-To: <20051214234016.0112a86e.akpm@osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2005 23:40:16 -0800, Andrew Morton <akpm@osdl.org> wrote:

>  Probably-unfixed bugs from -mm1 and -mm2 include:
[...]
>  - Grant Coady <grant_lkml@dodo.com.au>: "Locked up on boot just after
>    USB 2.0 initialised, EHCI 1.00 ..."

With ehci compiled in I get a kernel panic during boot, ehci as module 
and the things boots.  Then 'modprobe ehci_hcd' provokes a similar panic :(

Nothing useful in logs.

Grant.
