Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264383AbUADAPy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 19:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbUADAPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 19:15:54 -0500
Received: from cpc1-cosh4-5-0-cust84.cos2.cable.ntl.com ([81.96.30.84]:40584
	"EHLO slut.local.munted.org.uk") by vger.kernel.org with ESMTP
	id S264383AbUADAPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 19:15:52 -0500
Date: Sun, 4 Jan 2004 00:15:12 +0000 (GMT)
From: Alex Buell <alex.buell@munted.org.uk>
X-X-Sender: alex@slut.local.munted.org.uk
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: inode_cache / dentry_cache not being reclaimed aggressively
 enough  on low-memory PCs
In-Reply-To: <20040103145557.369a12c4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0401040014360.4975@slut.local.munted.org.uk>
References: <Pine.LNX.4.58.0401031128100.2605@slut.local.munted.org.uk>
 <20040103103023.77bf91b5.jlash@speakeasy.net> <20040103145557.369a12c4.akpm@osdl.org>
X-no-archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jan 2004, Andrew Morton wrote:

> John Lash <jlash@speakeasy.net> wrote:
> >
> > As it stands, it will maintain as many unused entries as there are used entries.
> >  If this low memory system las a large, stable, number of inuse dentry objects,
> >  the unused entries will match it thereby holding double the memory and possibly
> >  causing the problem you see.
> 
> Yup.   There is a fix in 2.6.1-rc1 for this.

Which change would that be? It would be nice to back-port that to 2.4.x if 
that's possible?

-- 
http://www.munted.org.uk

Your mother cooks socks in hell
