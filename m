Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266293AbUHVVhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266293AbUHVVhW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 17:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266303AbUHVVhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 17:37:22 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:15020 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S266293AbUHVVhU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 17:37:20 -0400
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: tonnerre@thundrix.ch, linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels?
References: <2vipq-7O8-15@gated-at.bofh.it> <2vj2b-8md-9@gated-at.bofh.it>
	<2vDtS-bq-19@gated-at.bofh.it> <E1ByXMd-00007M-4A@localhost>
	<412770EA.nail9DO11D18Y@burner> <412889FC.nail9MX1X3XW5@burner>
	<Pine.LNX.4.58.0408221450540.297@neptune.local>
	<m37jrr40zi.fsf@zoo.weinigel.se> <20040822192646.GH19768@thundrix.ch>
	<4128FE94.nail9U42DA799@burner> <20040822203321.GI19768@thundrix.ch>
	<4129055F.nail9V911J6JH@burner>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 22 Aug 2004 23:37:19 +0200
In-Reply-To: <4129055F.nail9V911J6JH@burner>
Message-ID: <m3hdqu3ldc.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> writes:

> Tonnerre <tonnerre@thundrix.ch> wrote:
> 
> > > -	What are the minimum requirements for a machine to run Linux?
> >
> > Intel 8086  processor with  a few ko  of RAM,  with a floppy  drive, a
> > monitor and a floppy, I think. If you take only the normal kernel into
> > account that will be an 80386 processor.
> 
> A few k ?????

It depends on your definition of "a few k" :-)

    http://elks.sourceforge.net/

It will run fine on an 8086 with 512 kBytes of RAM, but I its possible
to get by with as little as 200kByte of RAM.

I work with embedded Linux systems and the standard configuration for
the stuff I do is with a small embedded processor such as the Motorola
MPC860 or the Axis Etrax 100 (about as fast as an i486) and 8MByte of
RAM and 4MByte of flash.  It's really no problem running in 2MByte of
RAM and 2MByte of flash but then the system really just does one thing
such as initializing a routing table and then routing data back and
forth.  To be able to get OpenSSL running in there and so on I really
need 8MByte of RAM.

> > > -	What are the minimum requirements for a machine to run Solaris?
> >
> > At least more RAM and a more capable processor.
> 
> Looks like a speculation. 

Well, I think Solaris is still supported on my SPARCclassic, but I
really really wouldn't like to try it with only 8MByte of RAM.  

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
