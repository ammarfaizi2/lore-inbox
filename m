Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965200AbWEYQh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbWEYQh3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbWEYQh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:37:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37266 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965200AbWEYQh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:37:28 -0400
Date: Thu, 25 May 2006 09:36:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn,
       joern@wohnheim.fh-wedel.de, ioe-lkml@rameria.de
Subject: Re: [PATCH 09/33] readahead: events accounting
Message-Id: <20060525093627.4d37e789.akpm@osdl.org>
In-Reply-To: <348469540.16036@ustc.edu.cn>
References: <20060524111246.420010595@localhost.localdomain>
	<348469540.16036@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
> A debugfs file named `readahead/events' is created according to advises from
>  J?rn Engel, Andrew Morton and Ingo Oeser.

If everyone's patches all get merged up we'd expect that this facility be
migrated over to use Martin Peschke's statistics infrastructure.

That's not a thing you should do now, but it would be a useful test of
Martin's work if you could find time to look at it and let us know whether
the infrastructure which he has provided would suit this application,
thanks.

