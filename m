Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbVF2SkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbVF2SkY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVF2Sh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:37:58 -0400
Received: from station-6.events.itd.umich.edu ([141.211.252.135]:12727 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262418AbVF2Sg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:36:57 -0400
Date: Wed, 29 Jun 2005 18:44:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: torturing filesystems [was Re: reiser4 plugins]
Message-ID: <20050629164423.GD13336@elf.ucw.cz>
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB7B32.4010100@slaphack.com> <1119612849.17063.105.camel@localhost.localdomain> <42BC5D2E.1070307@namesys.com> <1119806434.28644.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119806434.28644.15.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Alan, this is FUD.   Our V3 fsck was written after everything else was,
> > for lack of staffing reasons (why write an fsck before you have an FS
> > worth using).  As a result, there was a long period where the fsck code
> > was unstable.  It is reliable now. 
> > 
> > People often think that our tree makes fsck less robust.  Actually fsck
> > can throw the entire internal tree away and rebuild from leaf nodes, and
> > frankly that makes things pretty robust. 
> 
> I did a series of tests well after resier3 had fsck that consisted of
> modelling the behaviour of systems under error state. I modelled random
> bit errors, bit errors at a fixed offset (class ram failure), sector 4
> byte slip (known IDE fail case) and sectors going away.

Do you have that code somewhere? Best I could do was overwriting
random parts of partition with random data, you seem to have "more
interesting" failures...
							Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
