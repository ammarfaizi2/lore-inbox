Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbTBXRGq>; Mon, 24 Feb 2003 12:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267264AbTBXRGq>; Mon, 24 Feb 2003 12:06:46 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:53009 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265725AbTBXRGp>; Mon, 24 Feb 2003 12:06:45 -0500
Date: Mon, 24 Feb 2003 17:16:57 +0000
From: John Levon <levon@movementarian.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add module load profile hook
Message-ID: <20030224171657.GA96095@compsoc.man.ac.uk>
References: <20030221005412.GA95016@compsoc.man.ac.uk> <20030224025907.A75512C093@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224025907.A75512C093@lists.samba.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18nMDq-000NUM-00*nLfw135oMM6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 11:33:34AM +1100, Rusty Russell wrote:

> > What needs this ?
> 
> I was thinking those who want to roll their own two-stage init and
> delete.  I wouldn't implement them all at first, but putting a
> notifier in is simple, and it can be expanded later.

So you'll add code in case somebody might want it, but you refuse to fix
regressions wrt the old code because it's a "corner case" (as if corner
cases isn't exactly what makes things complicated) ? How odd :)

> ie. you'd just implement MODULE_INITIALIZED, and leave the rest.

OK, I'll look at doing it like this instead, if you want.

john
