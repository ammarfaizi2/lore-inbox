Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264696AbUD1GCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264696AbUD1GCY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 02:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264695AbUD1GCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 02:02:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:14735 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264696AbUD1GCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 02:02:21 -0400
Date: Tue, 27 Apr 2004 23:02:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: busterbcook@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
Message-Id: <20040427230203.1e4693ac.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brent Cook <busterbcook@yahoo.com> wrote:
>
>   Running any kernel from the 2.6.6-rc* series (and a few previous
>  -mm*'s),

It's a shame this wasn't reported earlier.

> the pdflush process starts using near 100% CPU indefinitely after
>  a few minutes of initial NFS traffic, as far as I can tell.

Please confirm that the problem is observed on the NFS client and not the
NFS server?  I'll assume the client.

What other filesystems are in use on the client?

Please describe the NFS mount options and the number of CPUs and the amount
of memory in the machine.  And please send me your .config, off-list.

Thanks.
