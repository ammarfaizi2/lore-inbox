Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289020AbSAUDuN>; Sun, 20 Jan 2002 22:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289026AbSAUDuE>; Sun, 20 Jan 2002 22:50:04 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:62724 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S289020AbSAUDt5>; Sun, 20 Jan 2002 22:49:57 -0500
Date: Mon, 21 Jan 2002 04:49:52 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Bruce Harada <bruce@ask.ne.jp>
Cc: Frank van de Pol <fvdpol@home.nl>, linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
Message-ID: <20020121044952.A21348@devcon.net>
Mail-Followup-To: Bruce Harada <bruce@ask.ne.jp>,
	Frank van de Pol <fvdpol@home.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0201181632000.18867-100000@filesrv1.baby-dragons.com> <14160.1011396163@ocs3.intra.ocs.com.au> <20020121002041.B1958@idefix.fvdpol.home.nl> <20020121095458.2bd9c7ed.bruce@ask.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020121095458.2bd9c7ed.bruce@ask.ne.jp>; from bruce@ask.ne.jp on Mon, Jan 21, 2002 at 09:54:58AM +0900
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 09:54:58AM +0900, Bruce Harada wrote:
> 
> ...and how would you guarantee that this setting remains set, in the face of
> some nasty little cracker screwing around with /dev/kmem?

If the attacker gained the ability to play with /dev/kmem, he can
already load modules into the kernel, regardless if the kernel is
actually compiled with module support or not. You can find various
papers describing how to do it via google, and AFAIK some rootkits are
already using those techniques, so it's even "scriptkiddy-ready".

Face it, there is absolutely /no/ security gain in disabling module
support.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
