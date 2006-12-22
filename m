Return-Path: <linux-kernel-owner+w=401wt.eu-S1751592AbWLVU77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbWLVU77 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 15:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbWLVU77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 15:59:59 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:46903 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbWLVU76 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 15:59:58 -0500
Date: Fri, 22 Dec 2006 13:00:27 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: 7eggert@gmx.de
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@lazybastard.org>,
       Yakov Lerner <iler.ml@gmail.com>, Kernel <linux-kernel@vger.kernel.org>
Subject: Re: two architectures,same source tree
Message-Id: <20061222130027.a42f5cf6.randy.dunlap@oracle.com>
In-Reply-To: <E1GxrGg-0001SL-3h@be1.lrz>
References: <7uewg-7Un-7@gated-at.bofh.it>
	<7ueZm-17M-25@gated-at.bofh.it>
	<E1GxrGg-0001SL-3h@be1.lrz>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2006 21:45:26 +0100 Bodo Eggert wrote:

> Jörn Engel <joern@lazybastard.org> wrote:
> > On Wed, 20 December 2006 20:32:20 +0200, Yakov Lerner wrote:
> 
> >> Is it easily possible to build two architectures in
> >> the same source tree (so that intermediate fles
> >> and resut files do not interfere ) ?
> > 
> > I'd try something like this:
> > make O=../foo ARCH=foo
> > make O=../bar ARCH=bar
> > 
> > But as I'm lazy I'll leave the debugging to you. :)
> 
> IIRC You'll have to specify ARCH= on each make call, but O= is saved in
> ../foo/Makefile.

Hm, top-level README file says:

   Please note: If the 'O=output/dir' option is used then it must be
   used for all invocations of make.


---
~Randy
