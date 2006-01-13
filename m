Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161558AbWAMQw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161558AbWAMQw2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 11:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161561AbWAMQw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 11:52:28 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:38199 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161558AbWAMQw2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 11:52:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UpyjqH8lC+VRvFRRkMv6Z5i4P/bcH3uS9r6NDYFO5BlH7/41l/1BGscO3pSKvZnOyZS+iPlpctwG22kJvJbK39rDai9UNA0KboMexmme1TAcxwYpPjaGFB6C37tkJY89XQYQa3MgOLZRMv4fKzHWmMEdxdPO4KEsqX92HKpEl+I=
Message-ID: <40f323d00601130852m7e501dccle4a95d8eecfabe23@mail.gmail.com>
Date: Fri, 13 Jan 2006 17:52:25 +0100
From: Benoit Boissinot <bboissin@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] reiserfs: remove kmalloc wrapper
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
In-Reply-To: <Pine.LNX.4.61.0601131553570.7435@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0601130930130.17696@sbz-30.cs.Helsinki.FI>
	 <20060112233920.4b3b0a26.akpm@osdl.org>
	 <Pine.LNX.4.58.0601130942540.20349@sbz-30.cs.Helsinki.FI>
	 <20060112234846.3a20f5a1.akpm@osdl.org>
	 <Pine.LNX.4.58.0601130951160.22049@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.61.0601131553570.7435@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> >> It would have helped had you described the exact /proc pathname so people
> >> could remember whether there's anything which actually uses it.
> >
> >That would be /proc/fs/reiserfs/super, I think.
>
> I am on 2.6.15-rc6 and there is no /proc/fs/reiserfs, even though my
> rootfs is reiserfs (and therefore, is mounted, loaded, etc.).
>
You need CONFIG_REISERFS_PROC_INFO to have this proc entry.

regards,

Benoit
