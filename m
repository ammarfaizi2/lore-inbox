Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVEJVms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVEJVms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVEJVms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 17:42:48 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:51037 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261780AbVEJVl7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 17:41:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rEJD2b5c4ZffWslTVY7VampQg231KP6+vC3HXr8mhwA7IKh/fx4E2bIdguL8rJ09gfhR4F7qdmQAnzEsrVZgWzGoIdecw7A6+e08Vo1QGZ/b5cWdSYJGeUEUteYQ2s6Km91p6h6JIJaEZa/Jlo+krHfFhmnpEGAZ6WLXGVLtZog=
Message-ID: <7f800d9f0505101441596a3c42@mail.gmail.com>
Date: Tue, 10 May 2005 14:41:59 -0700
From: Andre Eisenbach <int2str@gmail.com>
Reply-To: Andre Eisenbach <int2str@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: High res timer?
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1115760541.14807.11.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7f800d9f050510132762f0ee7@mail.gmail.com>
	 <42811D51.1030106@tiscali.de>
	 <7f800d9f050510141626f70ee4@mail.gmail.com>
	 <1115760541.14807.11.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/5/10, Lee Revell <rlrevell@joe-job.com>:
> > Here's what I get if I try to nanosleep for 5 secs (for testing):
> >
> > -> 5.009952 s
> >
> > The .009952 part varies, but is very close to that usually.
> 
> Is this a 2.4 kernel?  The resolution on 2.6 should be 1ms, not ~10ms.

Yes indeed, that was a 2.4 kernel. On 2.6 (different machine though) I get:

-> 5.001064 s

Thanks,
    Andre
