Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265772AbUG2UpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUG2UpO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 16:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUG2Uns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 16:43:48 -0400
Received: from outmx003.isp.belgacom.be ([195.238.2.100]:2496 "EHLO
	outmx003.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265281AbUG2UlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 16:41:18 -0400
Subject: Re: [PATCHSET 2.6.7-rc2-ff3] Kernel webconfig
From: FabF <fabian.frederick@skynet.be>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040729131330.13accb5a.rddunlap@osdl.org>
References: <1089211577.3692.46.camel@localhost.localdomain>
	 <20040728095256.57aeed52.rddunlap@osdl.org>
	 <1091049074.7462.1.camel@localhost.localdomain>
	 <20040729100225.0e0b9aef.rddunlap@osdl.org>
	 <1091123009.2334.13.camel@localhost.localdomain>
	 <20040729131330.13accb5a.rddunlap@osdl.org>
Content-Type: text/plain
Message-Id: <1091133670.2334.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 29 Jul 2004 22:41:10 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-29 at 22:13, Randy.Dunlap wrote:
> On Thu, 29 Jul 2004 19:43:30 +0200 FabF wrote:
> 
> | Randy,
> | 
> | You're absolutely right ! I forgot to talk about that mandatory point :
> | 
> | Here's httpd.conf additions :
> | 
> | ScriptAlias /cgi-bin/ "/usr/src/linux-2.6.7-rc2-ff1/"
> | 
> | <Directory "/usr/src/linux-2.6.7-rc2-ff1/">
> |     AllowOverride None
> |     Options None
> |     Order allow,deny
> |     Allow from all
> | </Directory>
> | 
> | i.e. http://localhost/cgi-bin/wconf is mapped to wconf binary which is
> | generated in linux tree root.
> | 
> | Note that we could work another way around e.g. 
> | 	-Have CGI in apache original cgi-bin path
> | 	-Place some conf file with kernel tree.
> | ... That said, it's only in proto state :)
> 
> Hi again,
> 
> I still can't get it (the web server) to work, and I've spent
> too much time on it already, so I'll have to drop it for now.
> I think it's a neat idea, though.
You might want to look at apache log see if it's not access
relevant.wwwrun has to be linux-tree authoritative (eg brutal -R 777)

Regards,
FabF

> 
> Later,
> --
> ~Randy
> 

