Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263481AbTJBR0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 13:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263482AbTJBR0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 13:26:25 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:59628 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263481AbTJBR0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 13:26:23 -0400
Date: Thu, 2 Oct 2003 19:26:12 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Russell King <rmk@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] remove unnecessary #includes from <linux/fs.h>
Message-ID: <20031002172612.GG10382@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org> <20030928184642.GA1681@mars.ravnborg.org> <20030928191622.GA16921@wohnheim.fh-wedel.de> <20030928204224.G1428@flint.arm.linux.org.uk> <20030928200001.GC16921@wohnheim.fh-wedel.de> <20031002161639.GF10382@wohnheim.fh-wedel.de> <20031002172219.GA925@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031002172219.GA925@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 October 2003 19:22:19 +0200, Sam Ravnborg wrote:
> On Thu, Oct 02, 2003 at 06:16:39PM +0200, J�rn Engel wrote:
> > 
> > You didn't comment on my suggestion, so I've done it manually once for
> > linux/fs.h and was shocked.  It still passes my compile-standalone
> > test after removing 11! #include lines.
> 
> Be careful here.
> Maybe fs.h passes your compile test, but it may break other users of
> fs.h, that relyed on a certain .h file to be included by fs.h.
> This kind of clean-up belongs to 2.7.

Agreed.  Maybe Tim has his check-both-branches approach finished by
then, too.

J�rn

-- 
Good warriors cause others to come to them and do not go to others.
-- Sun Tzu
