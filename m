Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbUL2CRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbUL2CRN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 21:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbUL2CRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 21:17:13 -0500
Received: from 80-219-192-102.dclient.hispeed.ch ([80.219.192.102]:12958 "EHLO
	xbox.hb9jnx.ampr.org") by vger.kernel.org with ESMTP
	id S261306AbUL2CRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 21:17:09 -0500
Subject: Re: ptrace single-stepping change breaks Wine
From: Thomas Sailer <sailer@scs.ch>
To: Mike Hearn <mh@codeweavers.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Jesse Allen <the3dfxdude@gmail.com>, Daniel Jacobowitz <dan@debian.org>,
       Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
In-Reply-To: <1101161953.13273.7.camel@littlegreen>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <419E42B3.8070901@wanadoo.fr>
	 <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
	 <419E4A76.8020909@wanadoo.fr>
	 <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
	 <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org>
	 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
	 <20041120214915.GA6100@tesore.ph.cox.net> <41A251A6.2030205@wanadoo.fr>
	 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
	 <1101161953.13273.7.camel@littlegreen>
Content-Type: text/plain
Organization: Supercomputing Systems AG
Date: Wed, 29 Dec 2004 03:14:19 +0100
Message-Id: <1104286459.7640.54.camel@gamecube.scs.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any news about the ptrace single-stepping breakage of wine?

The application that stopped working for me is xst, the Xilinx HDL
synthesizer (there's a free as in beer version at
http://www.xilinx.com/xlnx/xebiz/designResources/ip_product_details.jsp?sGlobalNavPick=PRODUCTS&sSecondaryNavPick=Design+Tools&key=DS-ISE-WEBPACK
). I'm currently at kernel 2.6.10-ac1 (as packaged by Arjan van de Ven),
and wine-20041201-1fc3winehq.

Compiling vhdl file H:/sailer/src/vhdl/xxx/vprim.vhd in Library synwork.
FATAL_ERROR:Xst:Portability/export/Port_Main.h:127:1.13 - This
application has discovered an exceptional condition from which it cannot
recover.  Process will terminate.  To resolve this error, please consult
the Answers Database and other online resources at
http://support.xilinx.com. If you need further assistance, please open a
Webcase by clicking on the "WebCase" link at http://support.xilinx.com

Thanks,
Tom


