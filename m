Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWCPILE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWCPILE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 03:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbWCPILE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 03:11:04 -0500
Received: from mail.gmx.de ([213.165.64.20]:8399 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750987AbWCPILB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 03:11:01 -0500
X-Authenticated: #14349625
Subject: Re: Which kernel is the best for a small linux system?
From: Mike Galbraith <efault@gmx.de>
To: gcoady@gmail.com
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Willy Tarreau <willy@w.ods.org>,
       Arjan van de Ven <arjan@infradead.org>,
       j4K3xBl4sT3r <jakexblaster@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1142482749.8369.12.camel@homer>
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com>
	 <1142237867.3023.8.camel@laptopd505.fenrus.org>
	 <opcb12964ic9im9ojmobduqvvu4pcpgppc@4ax.com>
	 <1142273212.3023.35.camel@laptopd505.fenrus.org>
	 <20060314062144.GC21493@w.ods.org>
	 <kv2d12131e73fjkp0hufomj152un5tbsj1@4ax.com>
	 <20060314222131.GB3166@flint.arm.linux.org.uk>
	 <Pine.LNX.4.61.0603152347210.20859@yvahk01.tjqt.qr>
	 <f78h1292orlp3vnrm2qq9c040ech0eduhg@4ax.com>
	 <1142482749.8369.12.camel@homer>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 09:12:28 +0100
Message-Id: <1142496748.10098.5.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 05:19 +0100, Mike Galbraith wrote:
> On Thu, 2006-03-16 at 10:32 +1100, Grant Coady wrote:
> > 
> > Certainly provides little motivation for testers to provide any 
> > feedback does it not?  I've had two threads on sluggish terminal 
> > here performance without resolution.  2.6 feels sluggish, the test 
> > is simple and repeatable, your ridicule does not change that at all.
> 
> Hmm.  You have a testcase that's both simple _and_ repeatable?  Cool.
> What is it?

P.S.  if you're talking about ssh console slowdown thingie, as I write
this I'm ssh'd into my P3/500, and..

[root]:# time w
 09:07:02 up  2:44,  6 users,  load average: 3.74, 4.09, 3.34
USER     TTY        LOGIN@   IDLE   JCPU   PCPU  WHAT
root     tty1      06:23   10:11   0.17s  0.15s  -bash
root     tty2      08:43   23:34  41.09s 41.05s  top d1
root     tty3      08:49   22.00s  0.12s  0.10s  -bash
root     tty4      08:51    3:50   4.05s  3.95s  ab -c 50 -n 10000
http://localhost 81
root     tty5      09:04    1:12   0.06s  0.05s  -bash
root     pts/0     08:38    0.00s  0.18s  0.02s  w

real    0m0.033s
user    0m0.013s
sys     0m0.019s
[root]:#        

