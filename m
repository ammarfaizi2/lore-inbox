Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282960AbRK0Vcs>; Tue, 27 Nov 2001 16:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282967AbRK0Vcj>; Tue, 27 Nov 2001 16:32:39 -0500
Received: from air-1.osdl.org ([65.201.151.5]:37762 "EHLO water.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S282960AbRK0Vc1>;
	Tue, 27 Nov 2001 16:32:27 -0500
From: Nathan Dabney <smurf@osdlab.org>
Date: Tue, 27 Nov 2001 13:31:33 -0800
To: Robert Love <rml@tech9.net>
Cc: Joe Korty <l-k@mindspring.com>, mingo@elte.hu,
        Ryan Cumming <bodnar42@phalynx.dhs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
Message-ID: <20011127133133.C1168@osdlab.org>
In-Reply-To: <1006832357.1385.3.camel@icbm> <5.0.2.1.2.20011127020817.009ed3d0@pop.mindspring.com> <1006894385.819.2.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1006894385.819.2.camel@phantasy>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 03:53:04PM -0500, Robert Love wrote:
> Effecting all tasks matching a uid or some other filter is a little
> beyond what either patch does.  Note however that both interfaces have
> atomicity.

I don't see a need for that either, the inheritance and single-process change
are the major abilities needed.

> You can open and write to proc from within a program ... very easily, in
> fact.
> 
> Also, with some sed and grep magic, you can set the affinity of all
> tasks via the proc interface pretty easy.  Just a couple lines.

>From the admin point of view, this last ability is a good one.

A read-only entry in proc wouldn't do much good by itself.  The writable /proc
entry is the one that sounds interesting.

-Nathan

> 	Robert Love
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
