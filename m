Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVIQRgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVIQRgB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 13:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVIQRgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 13:36:01 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:20584 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751169AbVIQRgA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 13:36:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lH2ez0APhHfwZB1kmknI8RStfuIE0TrRcEpWqnYplw1gz7JFevjkWQH55e7iuCZg/ctbFs1fWaL0EFsKeUxa+oMcdDb48X9HVsGLRUceR6tNgOPNPkmvSoUNM71GflJszWbO2jNYaNwEBBwpWdFu3sfoIfwFpVRtYD8VagQA/ao=
Message-ID: <2c1942a705091710363f463b18@mail.gmail.com>
Date: Sat, 17 Sep 2005 20:36:00 +0300
From: Levent Serinol <lserinol@gmail.com>
Reply-To: lserinol@gmail.com
To: Jay Lan <jlan@engr.sgi.com>
Subject: Re: [PATCH] per process I/O statistics for userspace
Cc: Andrew Morton <akpm@osdl.org>, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       kaigai@ak.jp.nec.com, elsa-devel@lists.sourceforge.net,
       Erik Jacobson <erikj@subway.americas.sgi.com>,
       John Hesterberg <jh@sgi.com>
In-Reply-To: <432890BA.5090907@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2c1942a7050912052759c7f730@mail.gmail.com>
	 <20050914092338.GA2260@elf.ucw.cz>
	 <2c1942a705091413171e63bf55@mail.gmail.com>
	 <20050914132437.7c32b739.akpm@osdl.org>
	 <432890BA.5090907@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

 What's your last decision about the patch ?

On 9/15/05, Jay Lan <jlan@engr.sgi.com> wrote:
> Andrew,
> 
> These data are used in CSA Accounting today and i believe ELSA
> intends to use them also.
> 
> Since PAGG is not in the tree, SGI have been offering our customers
> PAGG/JOB/CSA kernel code as either kernel patches at oss.sgi.com
> site or out-of-tree kernel modules today.
> 
> SGI intends to submit another solution for PAGG/JOB soon.
> 
> Once the future of PAGG/JOB becomes clear, we will know better how
> to integrate CSA and BSD accounting. We are not sitting on it.
> 
> Thanks,
>   - jay
> 
> 
> Andrew Morton wrote:
> > Levent Serinol <lserinol@gmail.com> wrote:
> >
> >>+int proc_pid_iostat(struct task_struct *task, char *buffer)
> >> +{
> >> +       return sprintf(buffer,"%llu %llu\n",task->rchar,task->wchar);
> >> +}
> >
> >
> > Those fields have been sitting there unused for months.  I'd like to hear
> > what the system accounting guys are intending to do with them before
> > proceeding, please.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 

Stay out of the road, if you want to grow old. 
~ Pink Floyd ~.
