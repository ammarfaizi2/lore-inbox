Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265082AbUGCMdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265082AbUGCMdL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 08:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbUGCMdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 08:33:11 -0400
Received: from hera.cwi.nl ([192.16.191.8]:60102 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265082AbUGCMdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 08:33:08 -0400
Date: Sat, 3 Jul 2004 14:33:01 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Andrew Clausen <clausen@gnu.org>
Cc: Szakacsits Szabolcs <szaka@sienet.hu>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Steffen Winterfeldt <snwint@suse.de>, linux-kernel@vger.kernel.org,
       Thomas Fehr <fehr@suse.de>, bug-parted@gnu.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
Message-ID: <20040703123301.GB20808@apps.cwi.nl>
References: <s5gwu1mwpus.fsf@patl=users.sf.net> <Pine.LNX.4.21.0407021528150.21499-100000@mlf.linux.rulez.org> <20040703013552.GA630@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040703013552.GA630@gnu.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 11:35:53AM +1000, Andrew Clausen wrote:

> I would welcome a co-maintainer though :)

Maybe dwm@austin.ibm.com wants to help.

> > > Parted needs a mechanism to let me FORCE the geometry it uses.  Every
> > > other partitioning tool has this, usually via command-line switch.
> 
> Would this solve any problems?

I think that is the wrong question.
This stuff is tricky. Especially when one has several operating systems
on a single disk some degree of control is required. Maybe you say
"in tricky cases use some other partition editor", but it seems
reasonable to offer users the opportunity to specify the desired
geometry.

Of course poor users will listen to the ignorant advice of their
neighbours and do all kinds of things to the geometry in attempts
to solve entirely unrelated problems. The number of support problems
will increase. So, try to supply accurate docs describing the cases
where changing the geometry may be useful, and warning that changing
the geometry may cause the loss of all data on the disk.

Andries


[yes - the discussion forks into many entirely different topics;
other answers in other letters]
