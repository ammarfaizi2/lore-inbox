Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265867AbTFSRnT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 13:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265868AbTFSRnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 13:43:18 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:27094 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265867AbTFSRnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 13:43:18 -0400
Date: Thu, 19 Jun 2003 10:58:17 -0700
From: Andrew Morton <akpm@digeo.com>
To: Steven Pratt <slpratt@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 umount hangs
Message-Id: <20030619105817.51613df2.akpm@digeo.com>
In-Reply-To: <3EF1EC73.4070305@austin.ibm.com>
References: <3EF1EC73.4070305@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jun 2003 17:57:17.0179 (UTC) FILETIME=[38BDCCB0:01C3368C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Pratt <slpratt@austin.ibm.com> wrote:
>
> Has anyone else seen hangs trying to umount ext3 volumes?

Nope.

>  I am seeing 
> this repeatedly after running tiobench on an ext3 volume.  This was only 
> showing up in the mm tree, but as of 2.5.72-bk2 I am now seeing it in 
> the mainline.

It would have been nice to have heard about it before this...

Could you please debug it a bit?  sysrq-T, etc?

Does the system hang, or does the umount hang?

