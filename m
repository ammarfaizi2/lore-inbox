Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266209AbTGIXaZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266217AbTGIXaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:30:25 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30386
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266209AbTGIXaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:30:21 -0400
Subject: Re: ->direct_IO API change in current 2.4 BK
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030709191739.GH15293@gtf.org>
References: <20030709133109.A23587@infradead.org>
	 <Pine.LNX.4.55L.0307091506180.27004@freak.distro.conectiva>
	 <16140.24595.438954.609504@charged.uio.no>
	 <200307092041.42608.m.c.p@wolk-project.de>
	 <16140.25619.963866.474510@charged.uio.no> <20030709190531.GF15293@gtf.org>
	 <16140.26693.72927.451259@charged.uio.no>  <20030709191739.GH15293@gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057794132.7137.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jul 2003 00:42:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-09 at 20:17, Jeff Garzik wrote:
> Having the stable API change, conditional on a define, is really
> nasty and IMO will create maintenance and support headaches down
> the line.  I do not recall Linux VFS _ever_ having a hook's definition
> conditional.  We should not start now...

The new quota code in 2.4.22pre already changed the rules slightly, as
do the shmemfs fixes if you are pedantic


