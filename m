Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268876AbTGOQrX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbTGOQrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:47:22 -0400
Received: from 64-238-252-21.arpa.kmcmail.net ([64.238.252.21]:15578 "EHLO
	kermit.unets.com") by vger.kernel.org with ESMTP id S268876AbTGOQrV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:47:21 -0400
Subject: Re: 2.6.0-test1-ac1 Matrox Compile Error
From: Adam Voigt <adam@cryptocomm.com>
Reply-To: adam@cryptocomm.com
To: dank@reflexsecurity.com
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org
In-Reply-To: <bf19d5$d00$1@main.gmane.org>
References: <1058285021.2209.13.camel@beowulf.cryptocomm.com>
	 <bf19d5$d00$1@main.gmane.org>
Content-Type: text/plain
Organization: Cryptocomm
Message-Id: <1058288545.2209.16.camel@beowulf.cryptocomm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jul 2003 13:02:25 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jul 2003 17:02:12.0489 (UTC) FILETIME=[D5BB9F90:01C34AF2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You were right, I missed VT support on the config, added
it and no more compile errors, thanks very much.




On Tue, 2003-07-15 at 12:16, nick black wrote:
> In article <1058285021.2209.13.camel@beowulf.cryptocomm.com>, Adam Voigt wrote:
> > Let me know if I'm being stupid, but here's the error I get,
> > and my .config is below:
> > 
> > 
> >   CHK     include/linux/compile.h
> >   UPD     include/linux/compile.h
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > drivers/built-in.o(.text+0x66e7a): In function `matroxfb_set_par':
> >: undefined reference to `default_grn'
> > drivers/built-in.o(.text+0x66e7f): In function `matroxfb_set_par':
> >: undefined reference to `default_blu'
> > drivers/built-in.o(.text+0x66e93): In function `matroxfb_set_par':
> >: undefined reference to `color_table'
> > drivers/built-in.o(.text+0x66e9b): In function `matroxfb_set_par':
> >: undefined reference to `default_red'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> you'll need to build VT support.
-- 
Adam Voigt (adam@cryptocomm.com)
Linux/Unix Network Administrator
The Cryptocomm Group

