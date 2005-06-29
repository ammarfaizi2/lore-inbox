Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVF2IHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVF2IHg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 04:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbVF2IHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 04:07:36 -0400
Received: from isilmar.linta.de ([213.239.214.66]:21485 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262472AbVF2IH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 04:07:28 -0400
Date: Wed, 29 Jun 2005 10:07:26 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Erik Slagter <erik@slagter.name>
Cc: linux-kernel@vger.kernel.org, Jim serio <jseriousenet@gmail.com>,
       Andrew Haninger <ahaning@gmail.com>
Subject: Re: C2/C3 on SMP [Was: Re: 2.6.X not recognizing second CPU]
Message-ID: <20050629080726.GA14930@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Erik Slagter <erik@slagter.name>, linux-kernel@vger.kernel.org,
	Jim serio <jseriousenet@gmail.com>,
	Andrew Haninger <ahaning@gmail.com>
References: <3642108305062711524e1e163@mail.gmail.com> <105c793f050627123583a70d0@mail.gmail.com> <3642108305062713487326b672@mail.gmail.com> <105c793f05062714022ad4359@mail.gmail.com> <20050627214249.GA29657@isilmar.linta.de> <1119958379.3969.9.camel@localhost.localdomain> <20050628212905.GA31610@isilmar.linta.de> <1120030846.7429.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120030846.7429.32.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 09:40:45AM +0200, Erik Slagter wrote:
> On Tue, 2005-06-28 at 23:29 +0200, Dominik Brodowski wrote:
> > On Tue, Jun 28, 2005 at 01:32:59PM +0200, Erik Slagter wrote:
> > > On Mon, 2005-06-27 at 23:42 +0200, Dominik Brodowski wrote:
> > > > a) Power Management is available on SMP, though support for it is a bit less
> > > >    wide-spread than it is for UP
> > > 
> > > Still no C2/C3 handling :-(
> > 
> > Uh, wasn't there a small, nice patch implementing this in bk-acpi a few 
> > weeks ago?
> > *clicketyclick* Oh yes,
> > http://bugzilla.kernel.org/show_bug.cgi?id=4401
> > states it was merged into bk-acpi-test on 2005-04-22. However, I can't find
> > it in current -mm any more...
> 
> You're probably talking about the amd768 module.

No, I'm not. I'm talking about plain ACPI C-States.

> I could use it, but I
> never got it working correctly, there is no actual power reduction. It
> may have to do with the fast (1000 Hz) 2.6 clock though, making it sleep
> in C2/C3 for only very short intervals. Also the selection for idle
> CPU's seems to be too simple.

The ACPI C-State selection algorithm needs a major overhaul, that's true.

	Dominik
