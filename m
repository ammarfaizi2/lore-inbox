Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTE0Mxp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTE0Mxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:53:45 -0400
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:31168 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263579AbTE0Mwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:52:46 -0400
Date: Tue, 27 May 2003 09:04:34 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.5.70, numerous ISDN build errors
Message-ID: <Pine.LNX.4.44.0305270902360.7293-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  again, some amalgamated output from "make allyesconfig".  after these
errors, i just deselected ISDN in its entirety.




  CC      drivers/isdn/hisax/diva.o
drivers/isdn/hisax/diva.c: In function `setup_diva':
drivers/isdn/hisax/diva.c:754: `cs' undeclared (first use in this function)
drivers/isdn/hisax/diva.c:754: (Each undeclared identifier is reported only once
drivers/isdn/hisax/diva.c:754: for each function it appears in.)
drivers/isdn/hisax/diva.c:761: parse error before "else"
drivers/isdn/hisax/diva.c: At top level:
drivers/isdn/hisax/diva.c:776: parse error before "if"
drivers/isdn/hisax/diva.c:795: parse error before string constant
drivers/isdn/hisax/diva.c:795: warning: type defaults to `int' in declaration of `printk'
drivers/isdn/hisax/diva.c:795: warning: function declaration isn't a prototype
drivers/isdn/hisax/diva.c:795: warning: data definition has no type or storage class
drivers/isdn/hisax/diva.c:602: warning: `diva_pci_probe' defined but not used
drivers/isdn/hisax/diva.c:629: warning: `diva_ipac_pci_probe' defined but not used
drivers/isdn/hisax/diva.c:656: warning: `diva_ipacx_pci_probe' defined but not used
drivers/isdn/hisax/diva.c:677: warning: `dev_diva' defined but not used
drivers/isdn/hisax/diva.c:678: warning: `dev_diva_u' defined but not used
drivers/isdn/hisax/diva.c:679: warning: `dev_diva201' defined but not used
make[3]: *** [drivers/isdn/hisax/diva.o] Error 1
make[2]: *** [drivers/isdn/hisax] Error 2
make[1]: *** [drivers/isdn] Error 2
make: *** [drivers] Error 2
  



  CC      drivers/isdn/hisax/sedlbauer.o
drivers/isdn/hisax/sedlbauer.c: In function `setup_sedlbauer':
drivers/isdn/hisax/sedlbauer.c:763: label `err' used but not defined
make[3]: *** [drivers/isdn/hisax/sedlbauer.o] Error 1
make[2]: *** [drivers/isdn/hisax] Error 2
make[1]: *** [drivers/isdn] Error 2
make: *** [drivers] Error 2
  



  CC      drivers/isdn/hisax/isurf.o
drivers/isdn/hisax/isurf.c: In function `setup_isurf':
drivers/isdn/hisax/isurf.c:240: `cs' undeclared (first use in this function)
drivers/isdn/hisax/isurf.c:240: (Each undeclared identifier is reported only once
drivers/isdn/hisax/isurf.c:240: for each function it appears in.)
make[3]: *** [drivers/isdn/hisax/isurf.o] Error 1
make[2]: *** [drivers/isdn/hisax] Error 2
make[1]: *** [drivers/isdn] Error 2
make: *** [drivers] Error 2



  CC      drivers/isdn/i4l/isdn_common.o
drivers/isdn/i4l/isdn_common.c: In function `drv_stat_stavail':
drivers/isdn/i4l/isdn_common.c:650: warning: control reaches end of non-void function
drivers/isdn/i4l/isdn_common.c: In function `map_drvname':
drivers/isdn/i4l/isdn_common.c:1981: structure has no member named `drvid'
drivers/isdn/i4l/isdn_common.c: In function `map_namedrv':
drivers/isdn/i4l/isdn_common.c:1988: structure has no member named `drvid'
drivers/isdn/i4l/isdn_common.c: In function `isdn_register_divert':
drivers/isdn/i4l/isdn_common.c:2010: `isdn_command' undeclared (first use in this function)
drivers/isdn/i4l/isdn_common.c:2010: (Each undeclared identifier is reported only once
drivers/isdn/i4l/isdn_common.c:2010: for each function it appears in.)
make[3]: *** [drivers/isdn/i4l/isdn_common.o] Error 1
make[2]: *** [drivers/isdn/i4l] Error 2
make[1]: *** [drivers/isdn] Error 2
make: *** [drivers] Error 2




rday
--

Robert P. J. Day
Eno River Technologies
Unix, Linux and Open Source training
Waterloo, Ontario

www.enoriver.com

