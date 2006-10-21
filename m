Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992758AbWJUAji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992758AbWJUAji (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 20:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWJUAji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 20:39:38 -0400
Received: from xenotime.net ([66.160.160.81]:30926 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030366AbWJUAjh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 20:39:37 -0400
Date: Fri, 20 Oct 2006 17:41:11 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: "J.A. =?ISO-8859-1?Q?Magall=F3n" ?= <jamagallon@ono.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm2
Message-Id: <20061020174111.996fa2bc.rdunlap@xenotime.net>
In-Reply-To: <20061021022438.46e5904f@werewolf-wl>
References: <20061020015641.b4ed72e5.akpm@osdl.org>
	<20061021022438.46e5904f@werewolf-wl>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Oct 2006 02:24:38 +0200 J.A. Magallón wrote:

> On Fri, 20 Oct 2006 01:56:41 -0700, Andrew Morton <akpm@osdl.org> wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/
> > 
> 
> Stupid question: how can I build sunrpc as a module ?
> My distro requires that, it tries to load it on initscripts to start
> part of the nfs subsystem.
> 
> I have digged through menuconfig and gconfig and am not able to set SUNRPC=m,
> it just gets autoselected y/n by other options.

(I think, not absolutely sure:)
If everything that selects it is a module (=m), then it should
also be selected as =m.  If anything that selects it =y, it will
also be =y.


---
~Randy
