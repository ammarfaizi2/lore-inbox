Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTJIL6O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 07:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbTJIL6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 07:58:14 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:39304 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S262074AbTJIL6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 07:58:12 -0400
Date: Thu, 9 Oct 2003 13:58:09 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
Cc: "Linux-Kernel \(E-mail\)" <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 thoughts
Message-ID: <20031009115809.GE8370@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be>
X-Operating-System: vega Linux 2.6.0-test5 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 10:08:00AM +0200, Frederick, Fabian wrote:
> Hi,
> 	Some thoughts for 2.7.Someone has other ideas, comments ?
[...] 	
> *	All this guides me to a more global conclusion in which all that
> stuff should be kobject registration relevant 
> *	Meanwhile, we don't have a kobject <-> security bridge :( 

well, maybe stupid ideas, but they're which supported on other unix like
system(s) or it would be very nice according to my experiences:

* bind mount support for all general mount options (nodev,ro,noexec etc)
  with SECURE implementation with any (maybe even future) filesystems?
* union mount (possible with option to declare on what fs a new file
  should be created: on fixed ones, random algorithm, on fs with the
  largest free space available etc ...)
* guaranteed i/o bandwidth allocation?
* netfilter's ability to do tricks which OpenBSD can do now with its
  packet filter
* ENBD support in official kernel with enterprise-class 'through the
  network' volume management
* more and more tunable kernel parameters to be able to have some user
  space program which can 'tune' the system for the current load,usage,etc
  of the server ("selftune")
* more configuration options to be able to use Linux at the low end as well
  (current kernels are too complex, too huge and sometimes contains too
  many unwanted features for a simple system, though for most times it is
  enough but can be even better)
* maybe some 'official in the kernel' general framework to implement
  virtual machines without the need to load third party kernel modeles
  from vmware, plex86 etc ...


-- 
- Gábor (larta'H)
