Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbTAaWmU>; Fri, 31 Jan 2003 17:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbTAaWmT>; Fri, 31 Jan 2003 17:42:19 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:64521 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262838AbTAaWmR>; Fri, 31 Jan 2003 17:42:17 -0500
Date: Fri, 31 Jan 2003 23:51:23 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "J.A. Magallon" <jamagallon@able.es>
cc: Jeff Garzik <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Perl in the toolchain
In-Reply-To: <20030131213827.GA1541@werewolf.able.es>
Message-ID: <Pine.LNX.4.44.0301312343150.9900-100000@serv>
References: <20030131133929.A8992@devserv.devel.redhat.com>
 <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu>
 <20030131194837.GC8298@gtf.org> <20030131213827.GA1541@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 31 Jan 2003, J.A. Magallon wrote:

> instead of
> - do all parsing in perl, that is what perl is for and what is mainly done
>   in kconfig scripts
> - do the config backend in perl, and...

Parsing is only the very first step to generate the dependency tree, which 
is used generate a consistent configuration, so most of the work are 
dependency calculations.
BTW if we use a script language I prefer ruby. :)

bye, Roman

