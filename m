Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263175AbRFGVLk>; Thu, 7 Jun 2001 17:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263173AbRFGVLb>; Thu, 7 Jun 2001 17:11:31 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52498 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263189AbRFGVLU>; Thu, 7 Jun 2001 17:11:20 -0400
Date: Thu, 7 Jun 2001 16:36:05 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM suggestion...
In-Reply-To: <3B1FEB7E.D06B10A2@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0106071631150.1156-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Jun 2001, Jeff Garzik wrote:

> While you guys are in there hacking, perhaps consider adding metrics
> which allows you to tell exactly when certain cases and conditions are
> hit.
> 	page_aged_while_sleeping_in_page_lauder++
> 
> Statistics like this are cheap to use in runtime and should provide
> concrete information rather than guesses and estimations...

I've been using LTT (Linux Trace Toolkit) to do similar stuff. 

The problem is that we _cannot_ base ourselves simply on practical results
from a _limited_ amount of workloads. Also remember the tests we (at least
I do) are benchmarks which try to use all resources all the time upon
completion.



