Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268703AbUIQLmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268703AbUIQLmU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 07:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268701AbUIQLmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 07:42:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:50090 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268703AbUIQLlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 07:41:10 -0400
Subject: Re: [PATCH] pmac: don't add =?ISO-8859-1?Q?=22=B0C=22?= suffix in
	sys for adt746x driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Colin Leroy <colin@colino.net>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.58.0409171249500.19914@waterleaf.sonytel.be>
References: <1095401127.5105.73.camel@gaston>
	 <Pine.GSO.4.58.0409171249500.19914@waterleaf.sonytel.be>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1095421135.5107.79.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 17 Sep 2004 21:38:57 +1000
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-17 at 20:50, Geert Uytterhoeven wrote:
> On Fri, 17 Sep 2004, Benjamin Herrenschmidt wrote:
> > The adt746x driver currently adds a "°C" suffix to temperatures exposed
> > via sysfs, and I don't like that. First, we all agree that any other unit
> > here makes no sense (do we ? do we ? yes of course :) and I don't like
> 
> Universal temperature, in K? And you'll never ever see negative numbers ;-)

I was waiting for this one :)

Ben.


