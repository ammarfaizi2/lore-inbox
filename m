Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbUKIFEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbUKIFEs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbUKIFEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:04:47 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:53680 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261371AbUKIFEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:04:34 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: james4765@verizon.net
Date: Tue, 9 Nov 2004 16:05:57 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16784.20533.56739.384864@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@redhat.com
Subject: Re: [PATCH] md: Documentation/md.txt update
In-Reply-To: message from james4765@verizon.net on Monday November 8
References: <20041109042030.11446.55146.88799@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 8, james4765@verizon.net wrote:
> Update status of superblock formats and fix misspellings in Documentation/md.txt

Thanks but ....

>  
> -The kernel does *NOT* autodetect which format superblock is being
> -used. It must be told.
> +The kernel will autodetect which format superblock is being used.

This is an incorrect change.  The kernel does *NOT* autodetect
superblock format.  I'm you really think it does, please point me at
the code.

>  
> -One started with RUN_ARRAY, uninitialised spares can be added with
> +One started with RUN_ARRAY, uninitialized spares can be added with

You corrected the wrong part of this line.
"One" at the beginning should be "Once".
"uninitialised" is correct  - in the Locale of the author.

NeilBrown
