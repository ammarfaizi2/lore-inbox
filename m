Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263009AbVGNLig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbVGNLig (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 07:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbVGNLig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 07:38:36 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:4039 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S263009AbVGNLid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 07:38:33 -0400
Date: Thu, 14 Jul 2005 13:38:24 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Albert Herranz <albert_herranz@yahoo.es>
cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: console remains blanked
In-Reply-To: <20050714101807.74323.qmail@web25805.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.61.0507141329270.26404@yvahk01.tjqt.qr>
References: <20050714101807.74323.qmail@web25805.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Before 2.6.12-rc2, the console was unblanked by just
>writing to the console.
>For keyboardless and mouseless systems (which is my
>case, embedded) this new behaviour is a bit annoying.

Interesting. I have observed the following (2.6.13-rc1 and a little 
earlier):
    mplayer bla.avi -vo cvidix
After the blanking time, all chars turn black[1] but are still "visible" 
thanks the movie in the background - a vga palette manipulation to the entries 
0-15 as it seems. This is quite different to writing 80x25 the space character.



Jan Engelhardt
-- 
