Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVC2Bsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVC2Bsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 20:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVC2Bsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 20:48:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:57002 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262142AbVC2Bsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 20:48:43 -0500
Date: Mon, 28 Mar 2005 17:48:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       ebiederm@xmission.com
Subject: Re: [RFC/PATCH 0/17][Kdump] Overview
Message-Id: <20050328174827.414a90a9.akpm@osdl.org>
In-Reply-To: <1112016341.4001.71.camel@localhost.localdomain>
References: <1112016341.4001.71.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> wrote:
>
>  Following patches (as in series file) need to be dropped before applying
>  the fresh ones.
> 
>  crashdump-documentation.patch
>  crashdump-memory-preserving-reboot-using-kexec.patch
>  crashdump-routines-for-copying-dump-pages.patch
>  crashdump-routines-for-copying-dump-pages-fixes.patch
>  crashdump-elf-format-dump-file-access.patch
>  crashdump-linear-raw-format-dump-file-access.patch
>  crashdump-linear-raw-format-dump-file-access-coding-style.patch

At some point we should stop tossing out patches and replacing them in this
manner.

Because doing so makes it hard for people to see what has changed.  

It makes it hard for people to see that changes in the above patches
haven't been simply lost.

And the fact that you were probably working against some kernel other than
-mm gives little confidence that the kdump development team have been
testing the patches which are presently in -mm.  And that is what they are
there for.


