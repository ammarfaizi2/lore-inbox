Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbVHENqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbVHENqF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 09:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbVHENqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 09:46:05 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:12303 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263019AbVHENqD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 09:46:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cY95Lk0InkpFO5GuJuBf6Nvm9iWFcgXF2fRDlU6Hp5OvJdy6CQ+GU2Pk/rBYX8y8ySbsln8xMjS2s3rKV7SKWeK8b/Eh8vptF2Nh+yS6OsXijD6+3mzc/hVSjoYz9ZzTTGIwi8rup7vooykbnJ2r5J/EWUQ8yI/8HRjvR4aAcxI=
Message-ID: <5a67a16f05080506452dcc537c@mail.gmail.com>
Date: Fri, 5 Aug 2005 09:45:58 -0400
From: Athul Acharya <aacharya@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Determining if the current processor is Hyperthreaded
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5a67a16f050802171478233f2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a67a16f05072909245ae1c44c@mail.gmail.com>
	 <42EFB3BB.1060900@tmr.com> <5a67a16f050802171478233f2f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/05, Athul Acharya <aacharya@gmail.com> wrote:
> That is, I want to know whether the current cpu I (kernel code) am
> executing on is hyperthreaded, and if so, which logical cpu represents
> the other thread on chip.

Trying again, as it seems like a simple thing that really should exist
 --  is_cpu_hyperthreaded(smp_processor_id()) -- or something similar.
 Anyone?

Athul
