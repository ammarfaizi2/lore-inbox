Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129249AbRCHRLf>; Thu, 8 Mar 2001 12:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129268AbRCHRLO>; Thu, 8 Mar 2001 12:11:14 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:63947 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S129249AbRCHRLI>;
	Thu, 8 Mar 2001 12:11:08 -0500
Date: Thu, 8 Mar 2001 18:10:38 +0100
From: David Weinehall <tao@acc.umu.se>
To: Steven Cole <scole@lanl.gov>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] remove CONFIG_NCR885E from Configure.help
Message-ID: <20010308181037.D18769@khan.acc.umu.se>
In-Reply-To: <01030808522000.01048@spc.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <01030808522000.01048@spc.esa.lanl.gov>; from scole@lanl.gov on Thu, Mar 08, 2001 at 08:52:20AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2001 at 08:52:20AM -0700, Steven Cole wrote:
> It appears that use of CONFIG_NCR885E was removed in 2.4.2-ac2,
> in Config.in and the Makefile in drivers/net.
> 
> If it really is the case that CONFIG_NCR885E is history, then it
> should be history in Configure.help as well.
> 
> This patch, against 2.4.2-ac14, removes CONFIG_NCR885E from Configure.help.
> 
> Steven
> 
> --- linux/Documentation/Configure.help.orig     Thu Mar  8 08:26:11 2001
> +++ linux/Documentation/Configure.help  Thu Mar  8 08:43:36 2001
> @@ -16511,16 +16511,6 @@
>    whenever you want). If you want to compile it as a module, say M
>    here and read Documentation/modules.txt.
>  
> -Symbios 53c885 (Synergy ethernet) support
> -CONFIG_NCR885E
> -  This is and Ethernet driver for the dual-function NCR 53C885

Oh, and if this entry stays, s/and/an/

> -  SCSI/Ethernet controller.
> -
> -  This driver is also available as a module called ncr885e.o ( = code
> -  which can be inserted in and removed from the running kernel
> -  whenever you want). If you want to compile it as a module, say M
> -  here and read Documentation/modules.txt.
> -
>  National DP83902AV (Oak ethernet) support
>  CONFIG_OAKNET
>    Say Y if your machine has this type of Ethernet network card.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
