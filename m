Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbVKPH6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbVKPH6B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 02:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbVKPH6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 02:58:00 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:30189 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030212AbVKPH57 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 02:57:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g/4dIOFaP195LZ6K1wBSissL1NRRjRXyNx6ANfdgZVMx2Jxviu0AjGpM7okD9fY/PaFAlCbQPbBQfEx5seEMlADL8rRV9oahBCMhMiQccEf0xLSPklwG2h129ABOTxrTinpJXkJcsREY8H61hI3nkTxXOxW5Pid7mh1no6DVjZo=
Message-ID: <aec7e5c30511152357g560127c6n88d0bce3b5a2f4e@mail.gmail.com>
Date: Wed, 16 Nov 2005 16:57:59 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 01/05] NUMA: Generic code
Cc: Magnus Damm <magnus@valinux.co.jp>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, pj@sgi.com, werner@almesberger.net
In-Reply-To: <p73sltxowx4.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051110090920.8083.54147.sendpatchset@cherry.local>
	 <200511110516.37980.ak@suse.de>
	 <aec7e5c30511150034t5ff9e362jb3261e2e23479b31@mail.gmail.com>
	 <200511151515.05201.ak@suse.de>
	 <aec7e5c30511152122w70703fbfl98bd377fb6fb9af4@mail.gmail.com>
	 <p73sltxowx4.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Nov 2005 08:48:39 +0100, Andi Kleen <ak@suse.de> wrote:
> Magnus Damm <magnus.damm@gmail.com> writes:
> >
> > For testing, your NUMA emulation code is perfect IMO. But for memory
> > resource control your NUMA emulation code may be too simple.
> >
> > With my patch, CONFIG_NUMA_EMU provides a way to partition a machine
> > into several smaller nodes, regardless if the machine is using NUMA or
> > not.
> >
> > This NUMA emulation code together with CPUSETS could be seen as a
> > simple alternative to the memory resource control provided by CKRM.
>
> I believe Werner tried to use it at some point for that and it just
> didn't work very well. So it doesn't seem to be very useful for
> that usecase.

Sorry, but which one did not work very well? CKRM memory controller or
NUMA emulation + CPUSETS?

Thanks,

/ magnus
