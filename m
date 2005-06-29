Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVF2IQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVF2IQl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 04:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVF2IQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 04:16:40 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:16290 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S262202AbVF2IQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 04:16:38 -0400
Subject: Re: C2/C3 on SMP [Was: Re: 2.6.X not recognizing second CPU]
From: Erik Slagter <erik@slagter.name>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, Jim serio <jseriousenet@gmail.com>,
       Andrew Haninger <ahaning@gmail.com>
In-Reply-To: <20050629080726.GA14930@isilmar.linta.de>
References: <3642108305062711524e1e163@mail.gmail.com>
	 <105c793f050627123583a70d0@mail.gmail.com>
	 <3642108305062713487326b672@mail.gmail.com>
	 <105c793f05062714022ad4359@mail.gmail.com>
	 <20050627214249.GA29657@isilmar.linta.de>
	 <1119958379.3969.9.camel@localhost.localdomain>
	 <20050628212905.GA31610@isilmar.linta.de>
	 <1120030846.7429.32.camel@localhost.localdomain>
	 <20050629080726.GA14930@isilmar.linta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 29 Jun 2005 10:18:03 +0200
Message-Id: <1120033083.4004.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-29 at 10:07 +0200, Dominik Brodowski wrote:
> > > > Still no C2/C3 handling :-( 
> > > Uh, wasn't there a small, nice patch implementing this in bk-acpi a few 
> > > weeks ago?
> > > *clicketyclick* Oh yes,
> > > http://bugzilla.kernel.org/show_bug.cgi?id=4401
> > > states it was merged into bk-acpi-test on 2005-04-22. However, I can't find
> > > it in current -mm any more...
> > You're probably talking about the amd768 module.
> No, I'm not. I'm talking about plain ACPI C-States.

OK, in that case, good!

> > I could use it, but I
> > never got it working correctly, there is no actual power reduction. It
> > may have to do with the fast (1000 Hz) 2.6 clock though, making it sleep
> > in C2/C3 for only very short intervals. Also the selection for idle
> > CPU's seems to be too simple.
> 
> The ACPI C-State selection algorithm needs a major overhaul, that's true.

The current C-state selection (as used on e.g. my laptop) is good enough
for me. It was the idle selection of the amd768 module that was ehrm...
suboptimal.

I am holding my breath here ;-) (and watching the -mm commits).
