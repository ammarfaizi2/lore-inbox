Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVCEBoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVCEBoV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 20:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbVCEBdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 20:33:18 -0500
Received: from smtp09.auna.com ([62.81.186.19]:1448 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S263709AbVCEB2A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 20:28:00 -0500
Date: Sat, 05 Mar 2005 01:27:59 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: nothing in /proc/fs/nfs/exports ?
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <1109937510l.11030l.0l@werewolf.able.es>
	<1109964999.10173.24.camel@lade.trondhjem.org>
In-Reply-To: <1109964999.10173.24.camel@lade.trondhjem.org> (from
	trond.myklebust@fys.uio.no on Fri Mar  4 20:36:39 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1109986079l.13844l.2l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.04, Trond Myklebust wrote:
> fr den 04.03.2005 Klokka 11:58 (+0000) skreiv J.A. Magallon:
> 
> > ===== /proc/fs/nfs/exports
> > # Version 1.1
> > # Path Client(Flags) # IPs
> > 
> > Nothing in xtab ? Nothing in /proc ? Why ?
> > 
> 
> "man exportfs". Read all about the 2.6 kernel's new mechanism for
> communication between mountd and the kernel.
> 

Thanks. After reading that twice, I realized I had not /proc/fs/nfs
mounted !!

BTW, my system has two dirs in /proc/fs, both nfs and nfsd. Which
is the correct one ? Is that a bug ?
I will have a manual mount of that, until I discover why my initscripts
stopped mounting that.

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.11-jam1 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1


