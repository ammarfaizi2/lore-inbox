Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263319AbVGOO3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbVGOO3z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 10:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263314AbVGOO3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 10:29:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:17375 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263309AbVGOO11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 10:27:27 -0400
Subject: Re: console remains blanked
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0507141329270.26404@yvahk01.tjqt.qr>
References: <20050714101807.74323.qmail@web25805.mail.ukl.yahoo.com>
	 <Pine.LNX.4.61.0507141329270.26404@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Sat, 16 Jul 2005 00:27:27 +1000
Message-Id: <1121437648.5963.28.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 13:38 +0200, Jan Engelhardt wrote:
> >Before 2.6.12-rc2, the console was unblanked by just
> >writing to the console.
> >For keyboardless and mouseless systems (which is my
> >case, embedded) this new behaviour is a bit annoying.
> 
> Interesting. I have observed the following (2.6.13-rc1 and a little 
> earlier):
>     mplayer bla.avi -vo cvidix
> After the blanking time, all chars turn black[1] but are still "visible" 
> thanks the movie in the background - a vga palette manipulation to the entries 
> 0-15 as it seems. This is quite different to writing 80x25 the space character.
> 

I don't think this is related to the patch Albert is talking about

Ben.


