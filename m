Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTJXI4w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 04:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTJXI4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 04:56:52 -0400
Received: from mailhost.cs.auc.dk ([130.225.194.6]:56271 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S262086AbTJXI4u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 04:56:50 -0400
Subject: Re: Kernel threads and SMP programming
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031024084823.GA28523@conectiva.com.br>
References: <1066984101.5097.26.camel@rade7.s.cs.auc.dk>
	 <20031024084823.GA28523@conectiva.com.br>
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1066985749.5101.36.camel@rade7.s.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 24 Oct 2003 10:55:49 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-24 at 10:48, Arnaldo Carvalho de Melo wrote:
> Em Fri, Oct 24, 2003 at 10:28:21AM +0200, Emmanuel Fleury escreveu:
> > Hi,
> > 
> > I have been googling a bit and looking on kernelnewbies, but I didn't
> > find any documentation on how to code kernel-space programs for SMP...
> > 
> > Can somebody give me a hint ?
> 
> http://www.linux-mag.com/2000-12/gear_01.html

Thanks.

> Perhaps outdated, haven't checked, but this is an article by Alessandro
> Rubini with the suggestive title "The Design of an In-Kernel Server", so

Hum, I should have guessed ! :)

> what was you using as keywords on google? :-)

I was stupidly using: SMP kernel thread coding

The truth is that I have a piece of code running in the kernel which is
performing OK when running on a mono-processor and which is just a
disaster on SMP... (about 10 time slower).

I'm trying to understand the reason of this, so even out dated
documentation is welcome (the concept can be more important than the
details).

Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.auc.dk

