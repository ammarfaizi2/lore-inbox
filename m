Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317539AbSHCMUE>; Sat, 3 Aug 2002 08:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317540AbSHCMUE>; Sat, 3 Aug 2002 08:20:04 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:22769 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317539AbSHCMUE>; Sat, 3 Aug 2002 08:20:04 -0400
Subject: Re: [PATCH] pdc20265 problem.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Orlov <nick.orlov@mail.ru>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020803012204.GA9047@nikolas.hn.org>
References: <Pine.LNX.4.44.0208022004150.3717-100000@freak.distro.conectiva>
	<Pine.SOL.4.30.0208030241540.18115-100000@mion.elka.pw.edu.pl> 
	<20020803012204.GA9047@nikolas.hn.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 03 Aug 2002 14:41:23 +0100
Message-Id: <1028382083.31733.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-03 at 02:22, Nick Orlov wrote:
> I think that question is _how often_ pdc20265 is used as primary
> controller? Actually I know a lot of mobos with pdc20265 as additional
> controller (and I don't see the one that uses it as primary). 
> 
> Don't forget about "ide=reverse" parameter that allows you to treat
> pdc20265 as primary if by default kernel treat pdc20265 as secondary.
> 
> So I don't see _any_ reason to force pdc20265 to be primary (onboard)
> unless CONFIG_PDC202XX_FORCE is set.

This is the wrong question.

The right question for a stable kernel is "Why isnt it behaving
precisely the same way as it did before the merge". What got confused in
the _FORCE stuff. Why did _FORCE checks even get into the raid probe not
another config option...

