Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWDXMp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWDXMp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 08:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWDXMp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 08:45:57 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:29450 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1750755AbWDXMp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 08:45:57 -0400
Date: Mon, 24 Apr 2006 14:45:56 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lars Marowsky-Bree <lmb@suse.de>, Valdis.Kletnieks@vt.edu,
       Ken Brush <kbrush@gmail.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060424124556.GA92027@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Lars Marowsky-Bree <lmb@suse.de>, Valdis.Kletnieks@vt.edu,
	Ken Brush <kbrush@gmail.com>, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <4445484F.1050006@novell.com> <200604182301.k3IN1qh6015356@turing-police.cc.vt.edu> <4446D378.8050406@novell.com> <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu> <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com> <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu> <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com> <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu> <20060424082424.GH440@marowsky-bree.de> <1145882551.29648.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145882551.29648.23.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 01:42:31PM +0100, Alan Cox wrote:
> On Llu, 2006-04-24 at 10:24 +0200, Lars Marowsky-Bree wrote:
> > On 2006-04-23T05:45:34, Valdis.Kletnieks@vt.edu wrote:
> > 
> > > > AppArmor are not likely to put careful thought into the policies that
> > > > they use?
> > > They're not likely to put careful thought into it, *AND* that saying things
> > > like "AppArmor is so *simple* to configure" only makes things worse - this
> > > encourages unqualified people to create broken policy configurations.
> > 
> > That is about the dumbest argument I've heard so far, sorry. 
> 
> Its the conclusion of most security experts I know that broken security
> is worse than no security at all. 

While that may be true[1], it gets a little annoying when broken is
meant to be synonymous to "not the SELinux model".  Especially since
there are aspects where SELinux' security can be considered broken,
complexity being one of them, crappy failure modes being another,
handling of new files a third, handling of namespaces a fourth.

Paths vs. inodes is religion, nothing else.  There are arguments for
and against on both sides.  LSM was supposed to be inclusive of all
beliefs, has that changed?

  OG.

[1] Why do we have uis and permission bits already?  After all, it's
not perfect hence broken, right?
