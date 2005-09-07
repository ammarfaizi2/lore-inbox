Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVIGSd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVIGSd6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbVIGSd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:33:58 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:12683 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932195AbVIGSd5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:33:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m+gOUr2RHz6oUtJUQu+bVS3DLz/uLvS4bMmv10iXKm8eeTDAdNE2V81VllelDyCJLbjFsw+96/avEX+loG+TT4ju2YJLpPTwbYFmSkYn3hnrQ9JNyJu88dHoqG3Ag3RzW2bHtmmTj7xZavfOx4mCnB38DGZMn1qJdmRGDlie2KE=
Message-ID: <29495f1d0509071133441e4ec2@mail.gmail.com>
Date: Wed, 7 Sep 2005 11:33:55 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: vatsa@in.ibm.com
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Cc: Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>, rmk+lkml@arm.linux.org.uk
In-Reply-To: <20050907181823.GF28387@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509031814.49666.kernel@kolivas.org>
	 <20050904212616.B11265@flint.arm.linux.org.uk>
	 <20050905053225.GA4294@in.ibm.com> <20050905054813.GC25856@us.ibm.com>
	 <20050905063229.GB4294@in.ibm.com> <431F11FF.2000704@tmr.com>
	 <29495f1d0509070942688059a6@mail.gmail.com>
	 <20050907171756.GB28387@in.ibm.com>
	 <29495f1d05090710276d64a3de@mail.gmail.com>
	 <20050907181823.GF28387@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/05, Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
> On Wed, Sep 07, 2005 at 10:27:43AM -0700, Nish Aravamudan wrote:
> > enter_all_cpus_idle() and exit_all_cpus_idle() would be better?
> 
> Looks perfect.
> 
> > No, I was saying what you were, if a little unclearly, so the caller
> > does something like:
> >
> > current_dyn_tick_timer->reprogram();
> > check_cpu_mask(nohz_cpu_mask);
> > if (we_are_last_idle)
> >   enter_all_cpus_idle();
> 
> Looks fine!

Great!

Thanks,
Nish
