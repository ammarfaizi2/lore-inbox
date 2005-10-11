Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVJKEYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVJKEYm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 00:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVJKEYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 00:24:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26031 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751238AbVJKEYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 00:24:40 -0400
Date: Mon, 10 Oct 2005 21:23:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: teigland@redhat.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/16] GFS: headers
Message-Id: <20051010212349.5d7e2c38.akpm@osdl.org>
In-Reply-To: <20051010190537.GA7683@mipter.zuzino.mipt.ru>
References: <20051010170948.GB22483@redhat.com>
	<20051010190537.GA7683@mipter.zuzino.mipt.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> > +#define GFS2_IOCTL_IDENTIFY      _GFS2C_(1)
>  > +#define GFS2_IOCTL_SUPER         _GFS2C_(2)
> 
>  Since patch is against -mm, please, add 2 entries to
>  Documentation/ioctl-mess.txt. Don't bother with "I: " and "O: ", since
>  they aren't finished yet.

Actually, a patch which is partially against -linus and partially against
-mm causes me considerable grief.  I usually end up having to split it up.

So a separate patch to update -mm-only stuff would be preferred.
