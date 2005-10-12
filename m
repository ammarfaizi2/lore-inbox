Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVJLBZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVJLBZO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 21:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVJLBZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 21:25:14 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:48292 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932391AbVJLBZM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 21:25:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kTHmjQTglmMaq6p7MtKbnFON/Ws0v8w/3DjlUgUzip9iusGMxhbzd1yc5d6FbhTaE6dRqHeUcxVzThWFTtKTSw7h3RxV7zQ+IWChBP9y9tAxv5k0MA5R1Mbu99mU4PxRtAQuqyLG0Nrt/RHQFUuZHEwDTXRJLqFbn74u+EfAE8I=
Message-ID: <5bdc1c8b0510111825k75fb25a6wfd7867d0dd823c1a@mail.gmail.com>
Date: Tue, 11 Oct 2005 18:25:11 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Latency data - 2.6.14-rc3-rt13
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1129080062.7094.7.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com>
	 <1128983301.18782.215.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101633lc45fbf8gd2677e5646dc6f93@mail.gmail.com>
	 <5bdc1c8b0510101649s221ab437scc49d6a49269d6b@mail.gmail.com>
	 <5bdc1c8b0510102045u7e4bc9eeld5b690b5e96c4a5f@mail.gmail.com>
	 <20051011111700.GA15892@elte.hu>
	 <5bdc1c8b0510111545n29b77010h8558a1b69c4bf12a@mail.gmail.com>
	 <1129075368.7094.3.camel@mindpipe>
	 <5bdc1c8b0510111809v2609879ai8aa0a8e283acb58d@mail.gmail.com>
	 <1129080062.7094.7.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Tue, 2005-10-11 at 18:09 -0700, Mark Knecht wrote:
> > Should free memory drop like that over time?
>
> Yes this is perfectly normal.  When a system first boots all the memory
> your apps aren't using is initially free.  As applications access more
> data over time then it will be cached in memory until free memory drops
> to near zero.
>
> "Free memory" is actually wasted memory - it's better to use all
> available RAM for caching.
>
> Lee

OK, non-intuitive for a guitar player, but good to know it's normal. Thanks!

In that case I'll just wait for an xrun and hope I catch something in
dmesg. We'll just have to wait and see.

Cheers,
Mark
