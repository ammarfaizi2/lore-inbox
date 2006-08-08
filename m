Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbWHHVf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWHHVf2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWHHVf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:35:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:63394 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965049AbWHHVfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:35:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bS0gLLOE+LOknea3Xhrfs8GGEWq7j/yJfBd8uMBAG6/FAWhe31rluOVmEAjwwMNpMEiUvjK+a9d0GOyHMCtdBI9gRQ0SWsJbxL2YSPlw1GKPeM6WovYPqCycNV/VLoqv53T2eSmgUkNCkuAIpwPgA0fb4r4YYqV+tZMJGnISDbY=
Message-ID: <e6babb600608081435l575f8ecdhbbc35066a8357f59@mail.gmail.com>
Date: Tue, 8 Aug 2006 14:35:22 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re: Problems with 2.6.17-rt8
Cc: "hui Bill Huey" <billh@gnuppy.monkey.org>, linux-kernel@vger.kernel.org,
       "Ingo Molnar" <mingo@elte.hu>, "Thomas Gleixner" <tglx@linutronix.de>,
       "Darren Hart" <dvhltc@us.ibm.com>
In-Reply-To: <Pine.LNX.4.58.0608081506060.16824@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com>
	 <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com>
	 <1154541079.25723.8.camel@localhost.localdomain>
	 <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com>
	 <1154615261.32264.6.camel@localhost.localdomain>
	 <20060808025615.GA20364@gnuppy.monkey.org>
	 <20060808030524.GA20530@gnuppy.monkey.org>
	 <e6babb600608081146k663e3ee4g4b93ba325bf9257e@mail.gmail.com>
	 <Pine.LNX.4.58.0608081506060.16824@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> How far back do you get this bug?  I mean if you go back and test the
> previous kernels, where did you start seeing this?

I have so far been unable to provoke the problem under 2.6.16-rt29.

I was able to provoke things once easily under 17-rt1, but subsequent
attempts to trigger the bug have so far yielded no results.

I'm back to poking at 16-rt29 to see if the problem is simply somewhat
less likely.

-- 
Robert Crocombe
rcrocomb@gmail.com
