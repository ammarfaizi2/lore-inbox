Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264848AbSKNKxe>; Thu, 14 Nov 2002 05:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbSKNKxd>; Thu, 14 Nov 2002 05:53:33 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:57102 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264848AbSKNKxd>; Thu, 14 Nov 2002 05:53:33 -0500
Date: Thu, 14 Nov 2002 12:00:11 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Modules and the Interfaces who Love Them (Take I) 
In-Reply-To: <20021114032456.5676D2C0C9@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0211141152450.2113-100000@serv>
References: <20021114032456.5676D2C0C9@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 14 Nov 2002, Rusty Russell wrote:

> I seriously question your taste in this matter.

BTW while talking about taste: I'd rather make certain modules not 
unloadable, than have code like stop_refcounts() in the kernel.
Module loading _and_ unloading could be so simple and fast, but it seems 
people prefer to keep the module stuff black magic. If nobody else cares I 
won't care either, alsa was the last reason I needed modules, now I can 
live without it.

bye, Roman

