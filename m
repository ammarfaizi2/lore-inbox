Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269543AbRHCSep>; Fri, 3 Aug 2001 14:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269544AbRHCSef>; Fri, 3 Aug 2001 14:34:35 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:18443 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269543AbRHCSeX>; Fri, 3 Aug 2001 14:34:23 -0400
Date: Fri, 3 Aug 2001 20:34:31 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Message-ID: <20010803203431.H31468@emma1.emma.line.org>
Mail-Followup-To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <phillips@bonn-fries.net> <0108030354130E.00440@starship> <200108030207.f7326OpR003086@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200108030207.f7326OpR003086@sleipnir.valparaiso.cl>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Aug 2001, Horst von Brand wrote:

> > He wants to be able to set a bit on the directory that specifies such 
> > behaviour for all files in the directory.  I don't see what's wrong 
> > with that.
> 
> That there isn't THE directory in which the file resides. There might be
> several, and setting the bit on one of them at random and expect it to work
> is a _lot_ of work. For no real use.

Well, if the file resides in a directory without that flag, it's not
synched. The application or its installation process should take care of
that. Suppose the MTA knows where it writes its queue files and which
must have this flag set accordingly.
