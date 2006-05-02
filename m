Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWEBQ1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWEBQ1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbWEBQ1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:27:15 -0400
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:29909 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S964915AbWEBQ1O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:27:14 -0400
To: David Woodhouse <dwmw2@infradead.org>
Cc: Avi Kivity <avi@argo.co.il>, Martin Mares <mj@ucw.cz>,
       Willy Tarreau <willy@w.ods.org>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com>
	<MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com>
	<20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il>
	<mj+md-20060502.111446.9373.atrey@ucw.cz>
	<445741F5.6060204@argo.co.il>
	<1146573767.14059.23.camel@pmac.infradead.org>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 02 May 2006 18:27:13 +0200
In-Reply-To: <1146573767.14059.23.camel@pmac.infradead.org>
Message-ID: <m3wtd4tmse.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> writes:

> On Tue, 2006-05-02 at 14:26 +0300, Avi Kivity wrote:
> > There are C++ embedded kernels in http://www.zipworld.com.au/~akpm/
> > and http://ecos.sourceware.org/, but I haven't looked at them, so I
> > can't say whether I consider them nice or not. 
> 
> eCos is nice enough -- because it's mostly C :)

And those parts that are C++ (from a 2 year old eCos dist) won't
compile with a modern g++.  I tried to compile RedBoot on a Fedora
Core 5 system and it was a very painful experience, old deprecated C++
code was breaking all over the place.  It may just have been the the
eCos configuration tool (which I belive is written in C++) that failed
to compile, but anyway, I had to use an older version of g++ and some
flag to make the old broken C++ code generate warnings, not errors.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
