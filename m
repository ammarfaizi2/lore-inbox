Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264320AbTKUIjI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 03:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTKUIjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 03:39:08 -0500
Received: from imap.gmx.net ([213.165.64.20]:32133 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264320AbTKUIjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 03:39:03 -0500
X-Authenticated: #4512188
Message-ID: <3FBDD01F.2060100@gmx.de>
Date: Fri, 21 Nov 2003 09:43:11 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm4
References: <20031118225120.1d213db2.akpm@osdl.org> <3FBDCCDF.9010304@gmx.de>
In-Reply-To: <3FBDCCDF.9010304@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Debug: sleeping function called from invalid context at mm/slab.c:1868
> in_atomic():1, irqs_disabled():0
> Call Trace:

[snip]

OK, I booted up mm3 based kernel and these errors do NOT appear. I 
remember having had this problem once before but somehow got rid of this 
by several recompilings of the kernel... Nevertheless it is a strange thing.


The other error on reboot also appears with mm3, but ONLY on reboot, but 
not on halt, IIRC. It appears on unmounting and before remounting as 
readonly. Something like atomic_dec_blah in atomic.h connected with ntfs.

Prakash

