Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVGJWAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVGJWAW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVGJV6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 17:58:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5263 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262119AbVGJV5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 17:57:22 -0400
Date: Sun, 10 Jul 2005 23:57:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mike Waychison <mike@waychison.com>
Cc: Wichert Akkerman <wichert@wiggy.net>, Bryan Henderson <hbryan@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxram@us.ibm.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Pekka J Enberg <penberg@cs.helsinki.fi>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: share/private/slave a subtree - define vs enum
Message-ID: <20050710215722.GA12054@elf.ucw.cz>
References: <Pine.LNX.4.61.0507081527040.3743@scrub.home> <OFF7ECFC50.4EDB3D93-ON88257038.0059F048-88257038.005AEAF4@us.ibm.com> <20050708180302.GC1165@wiggy.net> <42CEC17D.8020309@waychison.com> <20050708181502.GD1165@wiggy.net> <42CEE0A7.8090006@waychison.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CEE0A7.8090006@waychison.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>enums in C are (de?)promoted to integral types under most conditions, so 
> >>the type-checking is useless.
> >
> >
> >It's a warning in gcc afaik and spare should complain as well.
> 
> Check again.

Check sparse with -Wbitwise and enum properly marked as bitwise...

									Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
