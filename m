Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272851AbTHEQj4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270449AbTHEQjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:39:47 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:23680 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S272518AbTHEQj0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:39:26 -0400
Subject: Re: time for some drivers to be removed?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308051242.h75CgSj6028203@harpo.it.uu.se>
References: <200308051242.h75CgSj6028203@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060101338.1189.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Aug 2003 17:35:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-05 at 13:42, Mikael Pettersson wrote:
> On 27 Jul 2003 21:56:11 +0100, Alan Cox wrote:
> > On Sul, 2003-07-27 at 21:56, Adrian Bunk wrote:
> > > That's no problem for me.
> > > 
> > > The only question is how to call the option that allows building only on
> > > UP (e.g. cli/sti usage in the driver)? My suggestion was BROKEN_ON_SMP,
> > > would you suggest OBSOLETE_ON_SMP?
> > 
> > Interesting question - whatever I guess. We don't have an existing convention.
> > How many drivers have we got nowdays that failing on just SMP ?
> 
> ftape fails on SMP due to sti/save_flags/restore_flags removal.

The -ac tree has some stuff for this sitting in it but I've not been able to
find a tester..

