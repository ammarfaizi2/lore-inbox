Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTJXJBu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 05:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbTJXJBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 05:01:50 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:30219 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262098AbTJXJBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 05:01:49 -0400
Date: Fri, 24 Oct 2003 06:01:38 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Emmanuel Fleury <fleury@cs.auc.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel threads and SMP programming
Message-ID: <20031024090137.GB28523@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Emmanuel Fleury <fleury@cs.auc.dk>, linux-kernel@vger.kernel.org
References: <1066984101.5097.26.camel@rade7.s.cs.auc.dk> <20031024084823.GA28523@conectiva.com.br> <1066985749.5101.36.camel@rade7.s.cs.auc.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066985749.5101.36.camel@rade7.s.cs.auc.dk>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 24, 2003 at 10:55:49AM +0200, Emmanuel Fleury escreveu:
> The truth is that I have a piece of code running in the kernel which is
> performing OK when running on a mono-processor and which is just a
> disaster on SMP... (about 10 time slower).
> 
> I'm trying to understand the reason of this, so even out dated
> documentation is welcome (the concept can be more important than the
> details).

So take a look also at:

http://lwn.net/Articles/driver-porting/

This is a series of very good articles by Jonathan Corbet, some related
to SMP.

- Arnaldo
