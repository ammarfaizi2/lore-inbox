Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVAGBWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVAGBWN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVAGBWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:22:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:53913 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261270AbVAGBVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:21:50 -0500
Date: Thu, 6 Jan 2005 17:26:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][0/4] let's kill verify_area
Message-Id: <20050106172624.7cc2a142.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0501070212560.3430@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0501070212560.3430@dragon.hygekrogen.localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> verify_area() if just a wrapper for access_ok() (or similar function or 
> dummy function) for all arch's.

This sounds more like "let's kill Andrew".  I count 489 instances in the
tree.  Please don't expect this activity to take top priority ;)
