Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312687AbSDONf1>; Mon, 15 Apr 2002 09:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312690AbSDONf0>; Mon, 15 Apr 2002 09:35:26 -0400
Received: from loki.Informatik.Uni-Oldenburg.DE ([134.106.9.61]:50949 "EHLO
	walker.pmhahn.de") by vger.kernel.org with ESMTP id <S312687AbSDONf0>;
	Mon, 15 Apr 2002 09:35:26 -0400
Date: Mon, 15 Apr 2002 15:34:17 +0200
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: faster boots?
Message-ID: <20020415133417.GB1888@titan.lahn.de>
In-Reply-To: <200204080057.g380vbO00868@vindaloo.ras.ucalgary.ca> <3CB0EF0B.14D48619@zip.com.au> <20020408095717.GB27999@atrey.karlin.mff.cuni.cz> <20020408174333.A28116@kushida.apsleyroad.org> <20020408124803.A14935@redhat.com> <20020409015657.A28889@kushida.apsleyroad.org> <20020409222214.GK5148@atrey.karlin.mff.cuni.cz> <20020412114422.A24021@kushida.apsleyroad.org> <20020412114252.GB1893@atrey.karlin.mff.cuni.cz> <20020412152918.A24356@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: UUCP-Freunde Lahn e.V.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moin!

On Fri, Apr 12, 2002 at 03:29:18PM +0100, Jamie Lokier wrote:
> This is on ext3.  I wonder if journalling is causing a problem.  Pavel,
> are you running ext3?

ext3 ignored kflushd and writes directly to the hard-disk every 30 s.
Reading the ext2-devel mailing list at
http://lists.sourceforge.net/lists/listinfo/ext2-devel, the problem is
known and being worked on. Until then, don't use journalling on disk,
you want to spin down.

BYtE
Philipp
-- 
Carl von Ossietzky Universitaet Oldenburg
Betriebssysteme und verteilte Systeme
