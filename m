Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422909AbWHZB2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422909AbWHZB2i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 21:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWHZB2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 21:28:38 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:49208 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751107AbWHZB2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 21:28:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IWmGCbfYVvf1xilYCi/Mnf97jnxa6OG0cDndXXFTbYP6hhe1kLJd9V5yLLt+/1VKOkXI+DTDC3y+2Fin+wU1sFqyCguiqvBzfZk6cZ1ieD70qg7tNBqj0sOaN4LtecF5CPhYyOYRFZGg5zs/wMG7odFU3LjRqvSrDIRFaydiUV0=
Message-ID: <e6babb600608251828i601d91bep9c8ae73341e381d@mail.gmail.com>
Date: Fri, 25 Aug 2006 18:28:37 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "hui Bill Huey" <billh@gnuppy.monkey.org>
Subject: Re: rtmutex assert failure (was [Patch] restore the RCU callback...)
Cc: "Esben Nielsen" <nielsen.esben@gmail.com>, "Ingo Molnar" <mingo@elte.hu>,
       "Thomas Gleixner" <tglx@linutronix.de>, rostedt@goodmis.org,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <e6babb600608251824g7e61e28n1c453db05a4e773d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060818115934.GA29919@gnuppy.monkey.org>
	 <20060822232051.GA8991@gnuppy.monkey.org>
	 <e6babb600608231014r23886965k9cbc1fd3b80930bb@mail.gmail.com>
	 <20060823202046.GA17267@gnuppy.monkey.org>
	 <20060823210558.GA17606@gnuppy.monkey.org>
	 <20060823210842.GB17606@gnuppy.monkey.org>
	 <e6babb600608231822s1ce8b229ubdc85ce7544c6b4@mail.gmail.com>
	 <20060824014658.GB19314@gnuppy.monkey.org>
	 <20060825071957.GA30720@gnuppy.monkey.org>
	 <e6babb600608251824g7e61e28n1c453db05a4e773d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/06, Robert Crocombe <rcrocomb@gmail.com> wrote:
> Of 4 total attempts this way, two completed with no problems, one had

Drat, this isn't quite true.  There was one attempt with 'make', and
that produced the 1st BUG, but the latter three attempts were with
'make -j40': two were okay, and one produced the two BUGs.  Apologies.
 I will make additional attempts with 'make' only.

-- 
Robert Crocombe
rcrocomb@gmail.com
