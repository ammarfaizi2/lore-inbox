Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030581AbWJCWAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030581AbWJCWAe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030583AbWJCWAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:00:34 -0400
Received: from hera.kernel.org ([140.211.167.34]:11716 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030581AbWJCWAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:00:33 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Registration Weakness in Linux Kernel's Binary formats
Date: Tue, 3 Oct 2006 14:59:54 -0700
Organization: OSDL
Message-ID: <20061003145954.06b2aa49@freekitty>
References: <1df1788c0610031425p4f1ca206teb05590a91eb7659@mail.gmail.com>
	<198AC4CE-A2CC-41DB-8D53-BDFB7959781B@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Trace: build.pdx.osdl.net 1159912795 24966 10.8.0.54 (3 Oct 2006 21:59:55 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 3 Oct 2006 21:59:55 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.5; i486-pc-linux-gnu)
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by hera.kernel.org id k93Lxuuj031228
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006 17:53:30 -0400
Kyle Moffett <mrmacman_g4@mac.com> wrote:

> On Oct 03, 2006, at 17:25:07, Bráulio Oliveira wrote:
> > Just forwarding....
> 
> Well, you could have checked the list archives first to make sure the  
> idiot didn't send it here himself.  Secondly if you're going to  
> forward something like this best send it to security@kernel.org first.
> 
> Of course, it's partially the abovementioned idiot's fault for BCCing  
> a mailing list and several others:
> > To: undisclosed-recipients
> 
> > Hello,
> > The present document aims to demonstrate a design weakness found in  
> > the
> > handling of simply linked   lists   used   to   register   binary    
> > formats   handled   by Linux   kernel,   and   affects   all    
> > the   kernel families (2.0/2.2/2.4/2.6), allowing the insertion of  
> > infection modules in kernel  space that can be used by malicious  
> > users to create infection tools, for example rootkits.
> 
> Would be nice if I could get to your paper to actually read it, but  
> as it returns a 404 error I'm going to make one brief statement:
> 
> If you can load another binary format or access the "simply linked  
> lists" of the binfmt chain in any way, then you're root and therefore  
> there are easier ways to own the box than patching the kernel.
> 
> Cheers,
> Kyle Moffett

I looked at it, basically his argument which is all flowered up in pretty
pictures and security vulnerability language is:

   If root loads a buggy module then the module can be used to compromise
   the system.

Well isn't that surprising.

-- 
Stephen Hemminger <shemminger@osdl.org>

