Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315582AbSEIA4N>; Wed, 8 May 2002 20:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315583AbSEIA4M>; Wed, 8 May 2002 20:56:12 -0400
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:44513 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S315582AbSEIA4L>;
	Wed, 8 May 2002 20:56:11 -0400
Date: Wed, 8 May 2002 20:55:46 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Alexander.Riesen@synopsys.com, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020509005546.GA14348@nevyn.them.org>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Alexander.Riesen@synopsys.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020508172557.GB1044@riesen-pc.gr05.synopsys.com> <13244.1020903019@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 10:10:19AM +1000, Keith Owens wrote:
> On Wed, 8 May 2002 19:25:57 +0200, 
> Alex Riesen <Alexander.Riesen@synopsys.com> wrote:
> >i've found the reason: the make's stdin was redirected in /dev/null
> >(my make is aliased to a program prettifying output).
> 
> Use standard make.

Wouldn't you call it a bug anyway if running
'make -f Makefile-2.5 oldconfig < /dev/null' went on to build a kernel? 
That's pretty surprising behavior.

(Not saying that that does happen, but it's how I read Alex's message)

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
