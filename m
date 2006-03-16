Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWCPIx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWCPIx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 03:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbWCPIx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 03:53:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:20667 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751126AbWCPIx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 03:53:56 -0500
X-Authenticated: #14349625
Subject: Re: Which kernel is the best for a small linux system?
From: Mike Galbraith <efault@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: gcoady@gmail.com, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Willy Tarreau <willy@w.ods.org>, Arjan van de Ven <arjan@infradead.org>,
       j4K3xBl4sT3r <jakexblaster@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1142497893.1671.173.camel@mindpipe>
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com>
	 <1142237867.3023.8.camel@laptopd505.fenrus.org>
	 <opcb12964ic9im9ojmobduqvvu4pcpgppc@4ax.com>
	 <1142273212.3023.35.camel@laptopd505.fenrus.org>
	 <20060314062144.GC21493@w.ods.org>
	 <kv2d12131e73fjkp0hufomj152un5tbsj1@4ax.com>
	 <20060314222131.GB3166@flint.arm.linux.org.uk>
	 <Pine.LNX.4.61.0603152347210.20859@yvahk01.tjqt.qr>
	 <f78h1292orlp3vnrm2qq9c040ech0eduhg@4ax.com>
	 <1142482749.8369.12.camel@homer>  <1142496748.10098.5.camel@homer>
	 <1142497893.1671.173.camel@mindpipe>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 09:55:23 +0100
Message-Id: <1142499323.10098.14.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 03:31 -0500, Lee Revell wrote:
> On Thu, 2006-03-16 at 09:12 +0100, Mike Galbraith wrote:
> > P.S.  if you're talking about ssh console slowdown thingie, as I write
> > this I'm ssh'd into my P3/500, and..
> > 
> > [root]:# time w
> 
> > real    0m0.033s
> > user    0m0.013s
> > sys     0m0.019s
> > [root]:#         
> 
> I think you left out the result for 2.4.

I don't have a 2.4 kernel.  But no matter, I don't think it's going to
get much better than .033s.  Even if it did, .033s sure doesn't feel
sluggish to me.

Running ab from the other box is a bit slower since ssh is using the
same net ab is blasting (only net I have)..

[root]:# time netstat|grep :81|wc -l
   1645

real    0m0.259s
user    0m0.133s
sys     0m0.126s

...but still not what I'd call a slug.

	-Mike     

