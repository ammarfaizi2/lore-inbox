Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288593AbSAQLtW>; Thu, 17 Jan 2002 06:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288565AbSAQLtC>; Thu, 17 Jan 2002 06:49:02 -0500
Received: from ns.suse.de ([213.95.15.193]:60432 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288553AbSAQLsv>;
	Thu, 17 Jan 2002 06:48:51 -0500
Date: Thu, 17 Jan 2002 12:48:49 +0100
From: Dave Jones <davej@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Calling EISA experts
Message-ID: <20020117124849.F22171@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020117015456.A628@thyrsus.com> <20020117121723.B22171@suse.de> <3C46B718.26F52BD5@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C46B718.26F52BD5@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Jan 17, 2002 at 06:35:52AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 06:35:52AM -0500, Jeff Garzik wrote:
 > >  > Does anything in /proc or elswhere reliably register the presence of EISA?
 > >  Not afaik. I'm tempted to hack support for it into driverfs.
 > The EISA_bus global variable indicates presence...

 *nod*, though you can almost guarantee this isn't what Eric wants.
 I'm assuming he wants something a'la /proc/pci
 Hacking the EISA code to register a driver in driverfs should be
 fairly trivial. I'll wait and see what Pat does with the
 busdriver reworking that he's up to right now before doing anything
 on this though.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
