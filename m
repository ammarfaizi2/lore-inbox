Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUFRV5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUFRV5k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUFRVzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:55:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:45030 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264500AbUFRVv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:51:28 -0400
Date: Fri, 18 Jun 2004 14:48:12 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: torvalds@osdl.org, geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cross-sparse
Message-Id: <20040618144812.2fe5ec3d.rddunlap@osdl.org>
In-Reply-To: <20040618213338.GA4975@MAIL.13thfloor.at>
References: <Pine.GSO.4.58.0406172304170.1495@waterleaf.sonytel.be>
	<Pine.LNX.4.58.0406180925210.4669@ppc970.osdl.org>
	<20040618213338.GA4975@MAIL.13thfloor.at>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004 23:33:38 +0200 Herbert Poetzl wrote:

| On Fri, Jun 18, 2004 at 09:27:22AM -0700, Linus Torvalds wrote:
| > On Thu, 17 Jun 2004, Geert Uytterhoeven wrote:
| > > 
| > > I wanted to give sparse a try on m68k, and noticed the current 
| > > infrastructure doesn't handle cross-compilation (no sane m68k 
| > > people compile kernels natively anymore, unless they run a 
| > > Debian autobuilder ;-).
| > > 
| > > After hacking the include paths in the sparse sources, installing 
| > > the resulting binary as m68k-linux-sparse, and applying the 
| > > following patch, it seems to work fine!
| > 
| > Hmm.. It does make sense, but at the same time, sparse isn't even really 
| > supposed to _care_ about the architecture. Especially not for a kernel 
| > build.
| 
| apologies for assasinating this thread ...
| 
| I did an 'extensive' search with google (you do not want 
| to know how many hits you get with 'sparse') and read 
| most postings on the sparse mailinglist (linux-sparse),
| found the freshmeat project pointing me to the 'new url'
| http://www.codemonkey.org.uk/projects/sparse/ where I can
| download 'sparse-2003-11-27.tar.gz', then found out that
| there should be a maintained (up to date) version of it at 
| 
|    http://www.kernel.org/pub/software/devel/sparse/
| 
| but what I find there, seems of no use to me ...
| (I'm no bitkeeper person) so I'm still looking for an url
| where I can get a recent .tar to install that beast.
| 
| can anybody point me in the right direction, please?

sure, get a tarball from here:
  http://www.codemonkey.org.uk/projects/bitkeeper/sparse/

--
~Randy
