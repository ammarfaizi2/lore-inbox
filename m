Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264672AbSL1Nc6>; Sat, 28 Dec 2002 08:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264711AbSL1Nc5>; Sat, 28 Dec 2002 08:32:57 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:17846 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S264666AbSL1Nc4>; Sat, 28 Dec 2002 08:32:56 -0500
Date: Sat, 28 Dec 2002 14:40:58 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Samuel Flory <sflory@rackable.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Janet Morgan <janetmor@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <20021228134058.GC13814@louise.pinerecords.com>
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com> <176730000.1040430221@aslan.btc.adaptec.com> <3E03BB0D.5070605@rackable.com> <Pine.LNX.4.50L.0212280331110.30646-100000@freak.distro.conectiva> <20021228091608.GA13814@louise.pinerecords.com> <Pine.LNX.4.50L.0212281131580.26879-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0212281131580.26879-100000@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[riel@conectiva.com.br]
> 
> On Sat, 28 Dec 2002, Tomas Szepe wrote:
> 
> > Marcelo, you've been overlooking these updates for a bit too long now
> > for your "let's throw them at -ac" to sound fair.  IMHO of course.  Also
> > remember those are both production drivers tested thoroughly in FreeBSD,
> 
> Are we talking about the old or the new aic7xxx driver ?

The new one.

> If it's the new driver, it's breaking on WAY too many
> machines and I have no idea why it got ever merged...
> 
> I have yet to see a machine where the new aic7xxx driver
> works. I'm sure they exist, but it doesn't work on any
> of the machines I have access to.

Oh?  I'm surprised to hear that, because the Gibbs driver
	1) works well for all the Adaptecs I've got. :)
	2) can drive certain chips the original driver can't
		(2940U's for instance).

-- 
Tomas Szepe <szepe@pinerecords.com>
