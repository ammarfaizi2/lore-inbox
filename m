Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbUDOTnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 15:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbUDOTnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 15:43:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:1256 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262608AbUDOTnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 15:43:12 -0400
Date: Thu, 15 Apr 2004 12:42:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: markw@osdl.org
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: 2.6.5-mm5
Message-Id: <20040415124255.4bde2f1f.akpm@osdl.org>
In-Reply-To: <200404151530.i3FFUI226872@mail.osdl.org>
References: <20040412221717.782a4b97.akpm@osdl.org>
	<200404151530.i3FFUI226872@mail.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

markw@osdl.org wrote:
>
> I have more results with DBT-2 on my 4-way Xeon system:
> 	http://developer.osdl.org/markw/fs/dbt2_project_results.html
> 
> It doesn't look like the latest cpu scheduler work is helping this
> workload.  I've also made sure that the database was set to use fsync
> instead of fdatasync so you can see if those fsync speedup patches are
> offering anything with this workload too.
> 
>            ext2  ext3
> 2.6.5-mm5  2165  1933
> 2.6.5-mm4  2180
> 2.6.5-mm3  2165  1930
> 2.6.5      2385
> 

Could we see 2.6.6-rc1 numbers please?
