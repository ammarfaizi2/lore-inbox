Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWC1QpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWC1QpV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 11:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWC1QpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 11:45:20 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:31193 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S1751096AbWC1QpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 11:45:19 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200603281644.k2SGish7001726@clem.clem-digital.net>
Subject: Re: Correction: 2.6.16-git12 killed networking -- 3c900 card
To: klassert@mathematik.tu-chemnitz.de (Steffen Klassert)
Date: Tue, 28 Mar 2006 11:44:54 -0500 (EST)
Cc: clem@clem.clem-digital.net (Pete Clements),
       linux-kernel@vger.kernel.org (linux-kernel),
       akpm@osdl.org (Andrew Morton)
In-Reply-To: <20060328141443.GB8455@gareth.mathematik.tu-chemnitz.de>
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.1590.1143564294--%"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--%--multipart-mixed-boundary-1.1590.1143564294--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Quoting Steffen Klassert
  > > 
  > > FYI:
  > >   Single 3c900 card, UP i386
  > >   Lost networking with .16-git12, message
  > >   ADDRCONF(NETDEV_UP): eth0: link is not ready
  > 
  > This could be due to the recent driver update.
  > I can not reproduce this with a 3c900B-Combo,
  > so I need some more information to track it down.

Data attached. Note:
 1) Using coax 10base2.
 2) Driver is compiled in, not a module. If you need I'll
    recompile with debug set.
  > 
  > >   Had several of these with git11
  > >   NETDEV WATCHDOG: eth0: transmit timed out
  > 
  > Is this for sure that these messages occured first time with git11?
  > There were no changes in the 3c59x driver between git10 and git11.

 Only occurrance in git11, 4 hits during a local net ftp. Low network 
 load system.

  > 
  > > 
  > >   No problems observed git1-git10
  > > 
  > 
  > If you are willing to provide me with some information
  > you can send the following:
  > 
  > 1. output of lspci -vvv (just the ethernet controller related part)
  > 
  > 2. your Kernel configuration
  > 
  > 3. modprobe the driver with debug=4 and send
  > the 3c59x related lines of your logs for both, git11 and git12.
  > (From driver startup about 15 seconds should be sufficiant for now)
  > 
  > 4. the output of "vortex-diag -aem" and "mii-diag".
  > You can find these tools at http://www.scyld.com/ethercard_diag.html
  > 
  > 
  > Steffen
  > -

-- 
Pete Clements 

--%--multipart-mixed-boundary-1.1590.1143564294--%
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Description: gzip compressed data, from Unix
Content-Disposition: attachment; filename="data.tgz"

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
gqXA4QIywKfNH+sAqTKKFrOn1zAfU9H3n2K7LPCJEWyuYzN6zAbJ6Z09cIbjE7YSX6CtQfTJ
OgahAhjsmeg5BUcQ4AXola6fyvLpCNpr1D5lz07Z8/PzE4ieP4TkWkHAKhpN1uMEOcMsVMd/
EkWuLUBDsjC9qAEgv1kwxsu6oDYRITOVOITKWaAO60r38QSRm967wMfK+8c6jEkAjdK/JyBh
OMhuhTvke9NoIGxURO3vYXAc1J/g21MCyd6Qw4FBbllhn0H+CZEX5pnfsIF4YELXoMhRjCd7
tpEmFiUQ7+gr2sQFaewNvh3CnxWMCNIIF2B3YHwJejX10YdVk3Ake7QJaip65X2Yx0mL9MJf
SK/BOo7BYD+33yYPm6ZxVa4tiANnkCU2bIc5p0gZTPYzxxcSjPzIwhFHekpCt0nhrBPY0tFH
SJlnD8ivR9qs75j+btvkf9x3rP/SZqj8j2fS+i9cnf99i0b9Aey3r/+S/63ujaL2B9Sf3daF
YerCMHVhmLowTF0Ypi4MUxeGqQvD1IVh6sIwdWGYIqwuDFOBqQvDbJF1YZi6MExdGKaMqwvD
1IVh6sIwdWGYujBMXRimiKgLw9SFYerCMBm+LgxDUP/xhWG2739/kPov6ftfcPz1+99v0fBc
6/ovdf2Xuv5LXf+lrv9S13/5kWVV13+p67/86JKt67/U9V/q+i91/Ze6/ktd/6Wu/1LXf6nr
v9TtR27b+98fpP5Lev8rtOr6D9+k1fVf6vovqf1/z/ovQsn+eThja/v/Fq2u/1LXf/mB678w
X7r+S/7R4vPHid9Kv33f+i/MF6z/chacnXfYDkiEh/CK5ffUfzln2bPppGImmy/fsf4Lt0Nd
1385WP+FSSlbXF3+pS7/Upd/qcu/1OVf6la3utWtbnWrW93qVre61a1udatb3epWt//u9v/b
AHX3AKAAAA==

--%--multipart-mixed-boundary-1.1590.1143564294--%--
