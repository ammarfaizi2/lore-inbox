Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263980AbUG2Udr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUG2Udr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 16:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUG2Udr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 16:33:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:28312 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263980AbUG2Udp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 16:33:45 -0400
Date: Thu, 29 Jul 2004 13:13:30 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: FabF <fabian.frederick@skynet.be>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET 2.6.7-rc2-ff3] Kernel webconfig
Message-Id: <20040729131330.13accb5a.rddunlap@osdl.org>
In-Reply-To: <1091123009.2334.13.camel@localhost.localdomain>
References: <1089211577.3692.46.camel@localhost.localdomain>
	<20040728095256.57aeed52.rddunlap@osdl.org>
	<1091049074.7462.1.camel@localhost.localdomain>
	<20040729100225.0e0b9aef.rddunlap@osdl.org>
	<1091123009.2334.13.camel@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004 19:43:30 +0200 FabF wrote:

| Randy,
| 
| You're absolutely right ! I forgot to talk about that mandatory point :
| 
| Here's httpd.conf additions :
| 
| ScriptAlias /cgi-bin/ "/usr/src/linux-2.6.7-rc2-ff1/"
| 
| <Directory "/usr/src/linux-2.6.7-rc2-ff1/">
|     AllowOverride None
|     Options None
|     Order allow,deny
|     Allow from all
| </Directory>
| 
| i.e. http://localhost/cgi-bin/wconf is mapped to wconf binary which is
| generated in linux tree root.
| 
| Note that we could work another way around e.g. 
| 	-Have CGI in apache original cgi-bin path
| 	-Place some conf file with kernel tree.
| ... That said, it's only in proto state :)

Hi again,

I still can't get it (the web server) to work, and I've spent
too much time on it already, so I'll have to drop it for now.
I think it's a neat idea, though.

Later,
--
~Randy
