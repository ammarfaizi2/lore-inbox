Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVDZNY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVDZNY6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 09:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVDZNY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 09:24:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17383 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261512AbVDZNYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 09:24:45 -0400
Date: Tue, 26 Apr 2005 15:19:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>, Miklos Szeredi <miklos@szeredi.hu>,
       jamie@shareable.org, linuxram@us.ibm.com, 7eggert@gmx.de, bulb@ucw.cz,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050426131943.GC2226@openzaurus.ucw.cz>
References: <3Xagd-5Wb-1@gated-at.bofh.it> <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org> <1114445923.4480.94.camel@localhost> <20050425191015.GC28294@mail.shareable.org> <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu> <20050426091921.GA29810@infradead.org> <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426094727.GA30379@infradead.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Christoph, you are being thickheaded, and this is not the first time.
> > Please go away.
> 
> Please stop the flaming.  You're adding the equivalent of "I've added
...
> You're really falling into the Hans Reiser trap - if you just wanted to
> add a simple userland filesystem you'd be done by now, but you're trying
> to funnel new semantics in through it.  Which is by far not as easy as
> adding a simple file system driver and needs a lot more though.  

Could we get root-only fuse in, please? It is usefull on its own...

In many cases you can just run one fused for all the users and handle
priviledges inside fused...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

