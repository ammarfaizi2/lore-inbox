Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbUBZEZN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 23:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbUBZEZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 23:25:12 -0500
Received: from nevyn.them.org ([66.93.172.17]:59528 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262671AbUBZEZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 23:25:09 -0500
Date: Wed, 25 Feb 2004 23:24:54 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: George Anzinger <george@mvista.com>
Cc: Tom Rini <trini@kernel.crashing.org>, Pavel Machek <pavel@suse.cz>,
       "Amit S. Kale" <amitkale@emsyssoft.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: kgdb: rename i386-stub.c to kgdb.c
Message-ID: <20040226042454.GA31771@nevyn.them.org>
Mail-Followup-To: George Anzinger <george@mvista.com>,
	Tom Rini <trini@kernel.crashing.org>, Pavel Machek <pavel@suse.cz>,
	"Amit S. Kale" <amitkale@emsyssoft.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
References: <20040224130650.GA9012@elf.ucw.cz> <200402251303.50102.amitkale@emsyssoft.com> <20040225103703.GB6206@atrey.karlin.mff.cuni.cz> <403D10DB.8060506@mvista.com> <20040225212826.GE1052@smtp.west.cox.net> <403D2230.8070000@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403D2230.8070000@mvista.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 02:31:12PM -0800, George Anzinger wrote:
> I would guess it is a problem in the emacs interface where one points at a 
> location in the code window and enters a command to set a break point ( I 
> think it is "^x " (control X space)).  It would appear that emacs then only 
> sends the file name to gdb rather than the full path.
> 
> This is not a show stopping problem, only confusing.  Once gdb figures out 
> the right source, all is well.  I usually do it by setting a break point at 
> the function by name, thus avoiding the point and grunt thing.

This is a known problem in the emacs interfaces; it will be fixed, but
I have no idea when the fixed version will be available :)

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
