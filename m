Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264936AbUHMKze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUHMKze (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbUHMKzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:55:01 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:55741 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262380AbUHMKyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:54:35 -0400
Date: Fri, 13 Aug 2004 12:54:25 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let W1 select NET
In-Reply-To: <1092394019.12729.441.camel@uganda>
Message-ID: <Pine.LNX.4.58.0408131253000.20634@scrub.home>
References: <20040813101717.GS13377@fs.tum.de>  <Pine.LNX.4.58.0408131231480.20635@scrub.home>
 <1092394019.12729.441.camel@uganda>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 13 Aug 2004, Evgeniy Polyakov wrote:

> On Fri, 2004-08-13 at 14:32, Roman Zippel wrote:
> > Hi,
> > 
> > On Fri, 13 Aug 2004, Adrian Bunk wrote:
> > 
> > >  config W1
> > >  	tristate "Dallas's 1-wire support"
> > > +	select NET
> > 
> > What's wrong with a simple dependency?
> 
> W1 requires NET, and thus depends on it.
> If you _do_ want W1 then you _do_ need network and then NET must be
> selected.

A simple "depends on NET" does this as well, I see no reason to abuse 
select.

bye, Roman
