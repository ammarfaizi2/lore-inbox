Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTIYHjR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 03:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbTIYHjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 03:39:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:48572 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261744AbTIYHjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 03:39:16 -0400
Date: Thu, 25 Sep 2003 00:39:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: mpm@selenic.com, rjwalsh@durables.org, wangdi@clusterfs.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kgdb-over-ethernet using netpoll api
Message-Id: <20030925003901.3da9cc4c.akpm@osdl.org>
In-Reply-To: <20030925070448.GD11901@openzaurus.ucw.cz>
References: <20030922184738.GM2414@waste.org>
	<20030925070448.GD11901@openzaurus.ucw.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Hi!
> 
> > This patch refactors kgdb-over-ethernet to use the netpoll API and
> 
> Whats the status of kgdb-over-ethernet for 2.4, btw?
> I tried googling for it but found nothing.

San did his original work against 2.4 maybe a year ago, but it wasn't
complete.  The route for 2.4 is to backport this latest work, and afaik
nobody is working on that.


