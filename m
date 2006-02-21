Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161475AbWBULDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161475AbWBULDi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 06:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161476AbWBULDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 06:03:38 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:35210 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1161475AbWBULDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 06:03:38 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 21 Feb 2006 12:01:14 +0100
To: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de
Cc: linux-kernel@vger.kernel.org, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43FAF2FA.nailD12BW90DH@burner>
References: <43EB7BBA.nailIFG412CGY@burner>
 <200602171502.20268.dhazelton@enter.net>
 <43F9D771.nail4AL36GWSG@burner>
 <200602201302.05347.dhazelton@enter.net>
 <43FAE10F.nailD121QL6LN@burner>
 <20060221101644.GA19643@merlin.emma.line.org>
In-Reply-To: <20060221101644.GA19643@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> Joerg Schilling schrieb am 2006-02-21:
>
> > Try to use my smake to find out whether you use non-portable constructs.
> > Smake warns you about the most common problems in makefiles.
>
> To complement this, running Solaris' /usr/{ccs,xpg4}/bin/make and BSD's
> portable make (just bootstrap www.pkgsrc.org to obtain "bmake" on Linux)
> is probably a much better approach since it tests real-world make
> implementations rather than an artificial and not widely available local
> flavor.

Thank you for proving that you are completely uninformed!

Smake is able to compile a _lot_ more real world applications than BSD make.

This is because smake is POSIX compliant while BSD make is not.

Smake is even able to compile more free software that depends on non-portable
GNU make extensions than Sun make does.

And smake warns about makefiles that only work because they depend on Bugs
found in Sun make or GNU make (e.g. because they try to expand '$*' or '$<'
in explicit target rules).

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
