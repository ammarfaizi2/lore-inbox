Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266094AbUFDX0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266094AbUFDX0M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266065AbUFDXYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 19:24:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:42722 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266094AbUFDXYQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 19:24:16 -0400
Date: Fri, 4 Jun 2004 16:24:10 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] NFS no longer updates file modification times  
 appropriately
Message-Id: <20040604162410.569c7ecc@dell_ss3.pdx.osdl.net>
In-Reply-To: <1086390495.4161.43.camel@lade.trondhjem.org>
References: <1086297112.3659.3.camel@lade.trondhjem.org>
	<20040604132355.GA31710@tsunami.ccur.com>
	<1086390495.4161.43.camel@lade.trondhjem.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Jun 2004 19:08:15 -0400
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> På fr , 04/06/2004 klokka 09:23, skreiv Joe Korty:
> 
> > Hi Trond,
> >  Thanks for the explanation.  What did 2.6.5 do differently that made it
> > appear to work?
> 
> Nothing in the NFS client...
> 
> The only difference might be if the VM decided to flush writes out
> earlier in order to reclaim memory.

What about fsync()?

-- 
Stephen Hemminger 		mailto:shemminger@osdl.org
Open Source Development Lab	http://developer.osdl.org/shemminger
