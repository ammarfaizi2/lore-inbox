Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262917AbVHEIIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbVHEIIQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 04:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbVHEIE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 04:04:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56762 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262897AbVHEIDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 04:03:55 -0400
Date: Fri, 5 Aug 2005 01:02:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Simon Matter" <simon.matter@invoca.ch>
Cc: linux-kernel@vger.kernel.org, kernel-maint@redhat.com,
       linux-raid@vger.kernel.org, dm-devel@redhat.com
Subject: Re: File corruption on LVM2 on top of software RAID1
Message-Id: <20050805010236.12d811ff.akpm@osdl.org>
In-Reply-To: <34082.213.188.237.106.1123228569.squirrel@localhost>
References: <45138.213.188.237.106.1123086677.squirrel@localhost>
	<20050804195853.0866ade9.akpm@osdl.org>
	<34082.213.188.237.106.1123228569.squirrel@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Simon Matter" <simon.matter@invoca.ch> wrote:
>
> While looking at some data corruption vulnerability reports on
>  Securityfocus I wonder why this issue does not get any attention from
>  distributors. I have an open bugzilla report with RedHat, have an open
>  customer service request with RedHat, have mailed peoples directly. No
>  real feedback.
>  I'm now in the process of restoring intergrity of my data with the help of
>  backups and mirrored data. Maybe I just care too much about other peoples
>  data, but I know that this bug will corrupt files on hundreds or thousands
>  of servers today and most people simply don't know it. Did I miss
>  something?

I guess the bug hit really rarely and maybe the reports were lost in the
permanent background noise of dodgy hardware.

We only found and fixed it last week, due to much sleuthing by Matthew
Stapleton.  I assume vendor updates are in the pipeline.
