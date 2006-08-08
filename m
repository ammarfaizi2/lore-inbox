Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbWHHWKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWHHWKn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 18:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWHHWKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 18:10:43 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:3014 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030318AbWHHWKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 18:10:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uKMnJa08qy8St05AbfMdqD+NZrVKBMwoo/2ypAgx5x3wnMNdmDaQI1j/w0l5ulH7En66DCDDuzyqEz2nNSY108uGeXywVTPMkg35CKXOfXaklKRaV/ErSBEa7IbNmx3oXCA+hKoLuYibu/5cyAEC4bcWagotez8Db8QIab3VESM=
Message-ID: <e6babb600608081510q62ea3cb5uf035947c4d9bbaa2@mail.gmail.com>
Date: Tue, 8 Aug 2006 15:10:40 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re: Problems with 2.6.17-rt8
Cc: "hui Bill Huey" <billh@gnuppy.monkey.org>, linux-kernel@vger.kernel.org,
       "Ingo Molnar" <mingo@elte.hu>, "Thomas Gleixner" <tglx@linutronix.de>,
       "Darren Hart" <dvhltc@us.ibm.com>
In-Reply-To: <Pine.LNX.4.58.0608081740530.17442@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com>
	 <1154541079.25723.8.camel@localhost.localdomain>
	 <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com>
	 <1154615261.32264.6.camel@localhost.localdomain>
	 <20060808025615.GA20364@gnuppy.monkey.org>
	 <20060808030524.GA20530@gnuppy.monkey.org>
	 <e6babb600608081146k663e3ee4g4b93ba325bf9257e@mail.gmail.com>
	 <Pine.LNX.4.58.0608081506060.16824@gandalf.stny.rr.com>
	 <e6babb600608081435l575f8ecdhbbc35066a8357f59@mail.gmail.com>
	 <Pine.LNX.4.58.0608081740530.17442@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> Is it easy to poke the problem with -rt8?  Just want to know if -rt8 has
> caused the problem to be more prevalent.

Yes.  It has been trivial to cause the problem under -rt7 and -rt8
(the upgrade from 7 was in hopes that -rt8 didn't have the problem).

-- 
Robert Crocombe
rcrocomb@gmail.com
