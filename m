Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUDPKcg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 06:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbUDPKcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 06:32:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46825 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262927AbUDPKca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 06:32:30 -0400
Date: Fri, 16 Apr 2004 12:34:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: markw@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: 2.6.5-mm5
Message-ID: <20040416103414.GA736@elte.hu>
References: <20040412221717.782a4b97.akpm@osdl.org> <200404151530.i3FFUI226872@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404151530.i3FFUI226872@mail.osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* markw@osdl.org <markw@osdl.org> wrote:

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

how stable are the results? Could the 2180 => 2165 drop be noise?

	Ingo
