Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263814AbRFSFkr>; Tue, 19 Jun 2001 01:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263797AbRFSFk1>; Tue, 19 Jun 2001 01:40:27 -0400
Received: from coruscant.franken.de ([193.174.159.226]:46097 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S263793AbRFSFkY>; Tue, 19 Jun 2001 01:40:24 -0400
Date: Tue, 19 Jun 2001 02:31:33 -0300
From: Harald Welte <laforge@gnumonks.org>
To: Nico Schottelius <nicos@pcsystems.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ipchains autoload
Message-ID: <20010619023133.L1598@corellia.laforge.distro.conectiva>
In-Reply-To: <3B205FE2.10271DE8@pcsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3B205FE2.10271DE8@pcsystems.de>; from nicos@pcsystems.de on Fri, Jun 08, 2001 at 07:17:22AM +0200
X-Operating-System: Linux corellia.laforge.distro.conectiva 2.4.3
X-Date: Today is Boomtime, the 21st day of Confusion in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2001 at 07:17:22AM +0200, Nico Schottelius wrote:
> Hello!
> 
> I don't really know howto specify that kmod
> should autoload the ipchains module, when I am
> using ipchains.
> 
> Anyone any idea howto tell kmod to load it then ?

there is no way to do that.

The problem is, that ipfwadm / ipchains and iptables use the same 
setsockopt() / getsockopt() based communication between kernel and 
userspace - so the kernel can never know which one of the three you want 
to load.

> Nico

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
