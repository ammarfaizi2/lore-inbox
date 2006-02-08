Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030546AbWBHFy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030546AbWBHFy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030548AbWBHFy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:54:28 -0500
Received: from web60215.mail.yahoo.com ([209.73.178.118]:9140 "HELO
	web60215.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030546AbWBHFy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:54:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=eyt1fk50wbvSSG/hFoUFQfZLaHCx+S9/9anCjQcOoc/HHoeehrFj20I/+gIa86wbzawlcM8IaVyNm+rhJXQGsFFPmqgi8BiBOqypWxBrf8XGDYCdrtvuz8enFl9iOmKoWOquFgIAKBoUmd2uX82sdwADroIr3glxh6YwiCip8rY=  ;
Message-ID: <20060208055426.76961.qmail@web60215.mail.yahoo.com>
Date: Tue, 7 Feb 2006 21:54:26 -0800 (PST)
From: anil dahiya <ak_ait@yahoo.com>
Subject: Re: Badness in sleep_on_timeout on kernel 2.6.9-1.667 ( fedora core 3)
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
In-Reply-To: <1139349028.3482.47.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

then which function i should use...beacause same
problem is with interruptible_sleep_on
thanks & Regards,
anil

--- David Woodhouse <dwmw2@infradead.org> wrote:

> On Tue, 2006-02-07 at 12:00 -0800, anil dahiya
> wrote:
> >  Badness in sleep_on_timeout at
> kernel/sched.c:3022
> >  [<02302bc3>] sleep_on_timeout+0x5d/0x23a
> >  [<0211b919>] default_wake_function+0x0/0xc
> > 
> > can any suggest how i can avoid this oops.
> 
> Stop using sleep_on_timeout(). It's almost certainly
> buggy.
> 
> -- 
> dwmw2
> 
> 
> --
> Kernelnewbies: Help each other learn about the Linux
> kernel.
> Archive:      
> http://mail.nl.linux.org/kernelnewbies/
> FAQ:           http://kernelnewbies.org/faq/
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
