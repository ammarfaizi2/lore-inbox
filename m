Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWFOCFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWFOCFa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 22:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWFOCFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 22:05:30 -0400
Received: from asclepius.uwa.edu.au ([130.95.128.56]:25545 "EHLO
	asclepius.uwa.edu.au") by vger.kernel.org with ESMTP
	id S932333AbWFOCF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 22:05:29 -0400
X-UWA-Client-IP: 130.95.13.9 (UWA)
Date: Thu, 15 Jun 2006 10:05:09 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: Fengguang Wu <fengguang.wu@gmail.com>,
       Bernard Blackham <b-lkml@blackham.com.au>, linux-kernel@vger.kernel.org,
       Lubos Lunak <l.lunak@suse.cz>, Dirk Mueller <dmueller@suse.de>,
       Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] the /proc/filecache interface
Message-ID: <20060615020509.GA18369@ucc.gu.uwa.edu.au>
References: <20060612075130.GA5432@mail.ustc.edu.cn> <20060614153837.GA16601@ucc.gu.uwa.edu.au> <20060615004034.GA5013@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060615004034.GA5013@mail.ustc.edu.cn>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.11+cvs20060403
X-SpamTest-Info: Profile: Formal (396/060608)
X-SpamTest-Info: Profile: Detect Hard [UCS 290904]
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (UCS) [02-08-04]
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0125], KAS/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 08:40:34AM +0800, Fengguang Wu wrote:
> As for the "selectively ditching pages" function, my original scheme
> is to
>         - query /proc/filecache to answer the question of "which pages
>           are cached, and their status(referenced/active etc.)"
>         - run "fadvise filename page-offset pages" to ditch pages
> Do you think it as convenient?

Certainly. That would be a great feature to have! And in this age of
pushing every man and his cat out to userspace, a userspace binary
that identifies the specific pages that need to go will probably
keep the some of the kernel folk happy.

Thanks,

Bernard.

