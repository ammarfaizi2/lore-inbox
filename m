Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTJJU7Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 16:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTJJU7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 16:59:25 -0400
Received: from [217.172.69.25] ([217.172.69.25]:13972 "EHLO falafell.ghetto")
	by vger.kernel.org with ESMTP id S262610AbTJJU7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 16:59:23 -0400
Date: Fri, 10 Oct 2003 22:59:05 +0200
To: =?iso-8859-1?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
Message-ID: <20031010205905.GA1601@81.38.200.176>
Reply-To: piotr@member.fsf.org
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009115809.GE8370@vega.digitel2002.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031009115809.GE8370@vega.digitel2002.hu>
User-Agent: Mutt/1.5.4i
From: Pedro Larroy <piotr@member.fsf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 01:58:09PM +0200, Gábor Lénárt wrote:
> On Thu, Oct 09, 2003 at 10:08:00AM +0200, Frederick, Fabian wrote:
> > Hi,
> > 	Some thoughts for 2.7.Someone has other ideas, comments ?
> [...] 	
> > *	All this guides me to a more global conclusion in which all that
> > stuff should be kobject registration relevant 
> > *	Meanwhile, we don't have a kobject <-> security bridge :( 
> 
> well, maybe stupid ideas, but they're which supported on other unix like
> system(s) or it would be very nice according to my experiences:
> 
> * bind mount support for all general mount options (nodev,ro,noexec etc)
>   with SECURE implementation with any (maybe even future) filesystems?
> * union mount (possible with option to declare on what fs a new file
>   should be created: on fixed ones, random algorithm, on fs with the
>   largest free space available etc ...)
> * guaranteed i/o bandwidth allocation?
> * netfilter's ability to do tricks which OpenBSD can do now with its
>   packet filter

Can you describe those please?

> * ENBD support in official kernel with enterprise-class 'through the
>   network' volume management
> * more and more tunable kernel parameters to be able to have some user
>   space program which can 'tune' the system for the current load,usage,etc
>   of the server ("selftune")
> * more configuration options to be able to use Linux at the low end as well
>   (current kernels are too complex, too huge and sometimes contains too
>   many unwanted features for a simple system, though for most times it is
>   enough but can be even better)

Maybe hardware detection -> automatic kernel configuration maker


> * maybe some 'official in the kernel' general framework to implement
>   virtual machines without the need to load third party kernel modeles
>   from vmware, plex86 etc ...
> 


Regards.
-- 
  Pedro Larroy Tovar  |  piotr%member.fsf.org 

Software patents are a threat to innovation in Europe please check: 
	http://www.eurolinux.org/     
