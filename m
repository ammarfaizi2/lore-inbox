Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318961AbSICV20>; Tue, 3 Sep 2002 17:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318962AbSICV20>; Tue, 3 Sep 2002 17:28:26 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:22151 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318961AbSICV2Z>; Tue, 3 Sep 2002 17:28:25 -0400
Date: Tue, 3 Sep 2002 22:31:32 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Luca Barbieri <ldb@ldb.ods.org>, Pavel Machek <pavel@suse.cz>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH 1 / ...] i386 dynamic fixup/self modifying code
Message-ID: <20020903223132.A6848@kushida.apsleyroad.org>
References: <1030506106.1489.27.camel@ldb> <20020828121129.A35@toy.ucw.cz> <1030663192.1326.20.camel@irongate.swansea.linux.org.uk> <1030663772.1491.107.camel@ldb> <1030663955.1327.27.camel@irongate.swansea.linux.org.uk> <1030666256.1491.143.camel@ldb> <1030706279.3180.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1030706279.3180.26.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Aug 30, 2002 at 12:17:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> We certainly could perl the asm to drop in the right directives if it
> became an issue, but there are children on the list so lets worry about
> it if it becomes a problem

Other dirty tricks include __asm__ (".macro prefetcht0 addr; ....; .endm");

:-)

-- Jamie
