Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318014AbSFSVTz>; Wed, 19 Jun 2002 17:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318015AbSFSVTy>; Wed, 19 Jun 2002 17:19:54 -0400
Received: from ns.suse.de ([213.95.15.193]:26899 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318014AbSFSVTx>;
	Wed, 19 Jun 2002 17:19:53 -0400
Date: Wed, 19 Jun 2002 23:19:54 +0200
From: Dave Jones <davej@suse.de>
To: Rudmer van Dijk <rvandijk@science.uva.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.23-dj2
Message-ID: <20020619231954.M29373@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rudmer van Dijk <rvandijk@science.uva.nl>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020619205136.GA18903@suse.de> <200206192105.g5JL5u808895@mail.science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200206192105.g5JL5u808895@mail.science.uva.nl>; from rvandijk@science.uva.nl on Wed, Jun 19, 2002 at 11:08:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 11:08:58PM +0200, Rudmer van Dijk wrote:
 > got this error with make xconfig (which worked in -dj1):
 > 
 > make[1]: Entering directory `/usr/src/kernel/linux-2.5.23-dj2/scripts'
 >   Generating kconfig.tk
 > -: 172: incorrect argument

Bad voodoo in arch/i386/config.in
Change the == on line 172 to a single =

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
