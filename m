Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSFURLG>; Fri, 21 Jun 2002 13:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSFURLF>; Fri, 21 Jun 2002 13:11:05 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:13506 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S316675AbSFURLE>;
	Fri, 21 Jun 2002 13:11:04 -0400
Date: Fri, 21 Jun 2002 12:10:59 -0500
From: Nathan Straz <nstraz@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.2 and 2.4 performance issues
Message-ID: <20020621171058.GA27100@sgi.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1024678560.879.27.camel@lpinto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1024678560.879.27.camel@lpinto>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 05:55:55PM +0100, Luis Pedro de Moura Ribeiro Pinto wrote:
> I was asked (i'm a company freshman) to perform some tests between
> kernel versions 2.2 and 2.4, and after awhile searching i found a good
> set of benchmarking tools (aim7) from Caldera linux. 

Benchmarks are evil.  Sure they are useful at times, but for the most
part they get misused.  IMHO, aim7 is outdated.  The I/O it does it all
very small for today's systems.  It's like poking the system with
hundreds of needles.  You have no idea how the system will react to a
golf club, baseball bat, sledgehammer or a wet noodle.  Sure, some
people really like it and swear by it.  Benchmarking is better done with
an application set in mind and best done with the application set
itself. 

> Are there better way to perform the test besides using benchmark tools
> like this?

Run the applications you really care about.  There is also a good set of
benchmarks, including application specific ones at
http://lbs.sourceforge.net/.  

-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                                  http://ltp.sf.net/
