Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbUBUGQp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 01:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbUBUGQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 01:16:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:32143 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261517AbUBUGQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 01:16:44 -0500
Date: Fri, 20 Feb 2004 22:17:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Joe Thornber <thornber@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 5/6] dm: list targets cmd
Message-Id: <20040220221702.62f457fe.akpm@osdl.org>
In-Reply-To: <20040220153704.GS27549@reti>
References: <20040220153145.GN27549@reti>
	<20040220153704.GS27549@reti>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber <thornber@redhat.com> wrote:
>
> List targets ioctl.  [Patrick Caulfield]
>  
> ...

> +#define DM_LIST_VERSIONS _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, struct dm_ioctl)

Does this not need 64-bit emulation support?

Has it been tested on a 64-bit system?
