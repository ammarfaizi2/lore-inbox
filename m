Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbSLJUKT>; Tue, 10 Dec 2002 15:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265713AbSLJUKT>; Tue, 10 Dec 2002 15:10:19 -0500
Received: from havoc.daloft.com ([64.213.145.173]:26850 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S265711AbSLJUKS>;
	Tue, 10 Dec 2002 15:10:18 -0500
Date: Tue, 10 Dec 2002 15:17:58 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Daniel Egger <degger@fhm.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
Message-ID: <20021210201758.GB28712@gtf.org>
References: <009f01c2a000$f38885d0$3716a8c0@taipei.via.com.tw> <20021210055215.GA9124@suse.de> <1039504941.30881.10.camel@sonja> <1039539080.14302.29.camel@irongate.swansea.linux.org.uk> <1039549178.7224.7.camel@sonja>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039549178.7224.7.camel@sonja>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 08:39:38PM +0100, Daniel Egger wrote:
> Am Die, 2002-12-10 um 17.51 schrieb Alan Cox:
> 
> > Well if you optimise for ppro it won't actually always work. 
> 
> Yeah, I had to learn earlier that it seems to support certain 
> kind of cmovs but certainly not all of them and some other
> instructions seem also to be missing.

Yes.


> > Also thescheduling seems to be best with 486.
> > Remember the C3 is a single issue risc processor.
> 
> Do you have pointers to some optimisation manual or whatever?
> gcc currently defines the c3 as 486+mmx+3dnow however I doubt 
> that this model is entirely correct and as such leaves some 
> space for improvements.

Definitely.  Read my email message that went along with that commit for
more details ;-)  (finding it isn't hard, it's probably one of the few
gcc-patches mails I have ever sent)

