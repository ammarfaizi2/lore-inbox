Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319836AbSINARy>; Fri, 13 Sep 2002 20:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319837AbSINARy>; Fri, 13 Sep 2002 20:17:54 -0400
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:63236 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S319836AbSINARx>; Fri, 13 Sep 2002 20:17:53 -0400
Date: Sat, 14 Sep 2002 02:22:43 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Possible bug and question about ide_notify_reboot in drivers/ide/ide.c (2.4.19)
Message-ID: <20020914002243.GE26758@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020913023744.78077.qmail@web40510.mail.yahoo.com> <1031922553.9056.18.camel@irongate.swansea.linux.org.uk> <20020913151037.GM28541@louise.pinerecords.com> <1031930097.9679.0.camel@irongate.swansea.linux.org.uk> <20020913175441.GN28541@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020913175441.GN28541@louise.pinerecords.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2002, Tomas Szepe wrote:

> > I dont think so. We can't go around with 15,000 "My bios cant XYZ"
> > options and "My PCI bus ...".
> 
> How about a kernel boot/module load option then?
> Something like "ide0=ata66,noshutdown"

So use reboot rather than halt. What's the issue here? Drives won't be
shut down on a reboot, and only use halt if you are to switch the power
off. (And if necessary, bug Epox about BIOS updates. Look as though the
board was not too old.)

-- 
Matthias Andree
