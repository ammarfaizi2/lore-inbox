Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266998AbTB1OYz>; Fri, 28 Feb 2003 09:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267089AbTB1OYy>; Fri, 28 Feb 2003 09:24:54 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34193
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266998AbTB1OYy>; Fri, 28 Feb 2003 09:24:54 -0500
Subject: Re: Protecting processes from the OOM killer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030228141917.GF159052@niksula.cs.hut.fi>
References: <3E5EB9A8.3010807@kegel.com>
	 <1046439618.16599.22.camel@irongate.swansea.linux.org.uk>
	 <20030228141917.GF159052@niksula.cs.hut.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046446674.16779.62.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Feb 2003 15:37:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-28 at 14:19, Ville Herva wrote:
> On Fri, Feb 28, 2003 at 01:40:19PM +0000, you [Alan Cox] wrote:
> > 
> > How about by not allowing your system to excessively overcommit.
> > Everything else is armwaving "works half the time" stuff. 
> 
> Which invites the question: the strict overcommit stuff from -ac (the 'echo
> {2,3} > /proc/sys/vm/overcommit_memory' stuff) hasn't found it's way to
> mainline yet, has it? I wonder if it would be compatible with up-to-date
> -aa vm...

Marcelo didn't want it for base. Its in 2.5 and in -ac. There is no
longer any rmap requirement on the code so it should "just work" with
the -aa changes too

