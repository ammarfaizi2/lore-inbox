Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266587AbUBMAIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 19:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266591AbUBMAIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 19:08:23 -0500
Received: from fungus.teststation.com ([212.32.186.211]:15883 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S266587AbUBMAIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 19:08:22 -0500
Date: Fri, 13 Feb 2004 01:08:43 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.local
To: Gabriel Devenyi <devenyga@mcmaster.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Linux 2.6.3-rc2-mm1 in fs/smbfs/inode.c
In-Reply-To: <200402121845.24144.devenyga@mcmaster.ca>
Message-ID: <Pine.LNX.4.44.0402130057450.28804-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004, Gabriel Devenyi wrote:

> This one has been around for a while, since at least 2.6.0.
>  
>  CC      fs/smbfs/inode.o
> fs/smbfs/inode.c: In function `smb_fill_super': 
> fs/smbfs/inode.c:554: warning: comparison is always false due to limited range 
> of data type
> fs/smbfs/inode.c:555: warning: comparison is always false due to limited range 
> of data type

Yes, I know, it's the SET_*ID() macros.

I believe they are used incorrectly and I have asked here what that change
was about. It's easy to change it back, but I'd like to know if the
previous was bad for some other reason first.

/Urban

