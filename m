Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289038AbSAIWHb>; Wed, 9 Jan 2002 17:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289042AbSAIWHJ>; Wed, 9 Jan 2002 17:07:09 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:4613 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S289038AbSAIWHH>; Wed, 9 Jan 2002 17:07:07 -0500
Date: Wed, 9 Jan 2002 23:07:04 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: "Eric S. Raymond" <esr@thyrsus.com>, Doug McNaught <doug@wireboard.com>,
        linux-kernel@vger.kernel.org, greg@kroah.com, felix-dietlibc@fefe.de
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020109230704.A25786@devcon.net>
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Doug McNaught <doug@wireboard.com>, linux-kernel@vger.kernel.org,
	greg@kroah.com, felix-dietlibc@fefe.de
In-Reply-To: <200201092005.g09K5OL28043@snark.thyrsus.com> <m3n0zn6ysr.fsf@varsoon.denali.to> <20020109154425.A28755@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020109154425.A28755@thyrsus.com>; from esr@thyrsus.com on Wed, Jan 09, 2002 at 03:44:25PM -0500
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 03:44:25PM -0500, Eric S. Raymond wrote:
> 
> You're right, I don't need this to be done at kernel level.  I do need it to
> be done *everywhere*.  I'm not sure how else to guarantee this will happen. 

Then add an init script and include installation of it to the
installation steps of your autoconfigurator (it has to be installed
anyway). If a distributor packages your program, he will include the
init script into his package and enable it according to his init
policy, or write an own init script, if your provided one doesn't
fit.

That's the way it works for network daemons etc. for years.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
