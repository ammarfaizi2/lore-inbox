Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbVEMOXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbVEMOXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 10:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbVEMOXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 10:23:40 -0400
Received: from nevyn.them.org ([66.93.172.17]:41372 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262380AbVEMOXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 10:23:38 -0400
Date: Fri, 13 May 2005 10:23:36 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Gabor MICSKO <gmicsko@szintezis.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050513142336.GA6174@nevyn.them.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	"Barry K. Nathan" <barryn@pobox.com>,
	Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org
References: <1115963481.1723.3.camel@alderaan.trey.hu> <20050513124735.GA7436@ip68-225-251-162.oc.oc.cox.net> <4284B55C.7010202@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4284B55C.7010202@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 10:10:36AM -0400, Jeff Garzik wrote:
> Barry K. Nathan wrote:
> >On Fri, May 13, 2005 at 07:51:20AM +0200, Gabor MICSKO wrote:
> >
> >>Is this flaw affects the current stable Linux kernels? Workaround?
> >>Patch?
> 
> Simple.  Just boot a uniprocessor kernel, and/or disable HT in BIOS.
> 
> 
> >Some pages with relevant information:
> >http://www.ussg.iu.edu/hypermail/linux/kernel/0403.2/0920.html
> >http://bugzilla.kernel.org/show_bug.cgi?id=2317
> 
> These pages have zero information on the "flaw."  In fact, I can see no 
> information at all proving that there is even a problem here.
> 
> Classic "I found a problem, but I'm keeping the info a secret" security 
> crapola.

FYI:
  http://www.daemonology.net/hyperthreading-considered-harmful/

I don't much agree with Colin about the severity of the problem, but
I've read his paper, which should be generally available later today.
It's definitely a legitimate issue.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
