Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261458AbTCQJtH>; Mon, 17 Mar 2003 04:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261466AbTCQJtH>; Mon, 17 Mar 2003 04:49:07 -0500
Received: from poup.poupinou.org ([195.101.94.96]:22532 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S261458AbTCQJtG>; Mon, 17 Mar 2003 04:49:06 -0500
Date: Mon, 17 Mar 2003 10:59:40 +0100
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: Ducrot Bruno <poup@poupinou.org>, Valdis.Kletnieks@vt.edu,
       Bongani Hlope <bonganilinux@mweb.co.za>, linux-kernel@vger.kernel.org
Subject: Re: 2.5 XFree and nvidia geforce.
Message-ID: <20030317095940.GC8814@poup.poupinou.org>
References: <3E70086B.6080408@lemur.sytes.net> <20030313201624.GA29107@suse.de> <Pine.LNX.4.51.0303132026210.24455@dns.toxicfilms.tv> <20030313231615.07563914.bonganilinux@mweb.co.za> <200303132155.h2DLtsRU015899@turing-police.cc.vt.edu> <20030314194050.GA8814@poup.poupinou.org> <Pine.LNX.4.51.0303142148570.15008@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0303142148570.15008@dns.toxicfilms.tv>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 09:50:49PM +0100, Maciej Soltysiak wrote:
> > One of the main issue for me (I don't want flame please) is
> > that it kill acpi and/or apm.
> Hmm, just insmoding the drivers kills apm/acpi ?
> 
> > BTW, XFree4.3.0 is out, and your GeForce is supported.
> So i've heard. :)
> 

By 'killing apm/acpi', I meant that the pm callback in the source
part of the kernel module call a function, certainly for saving/restoring
the state of the device, in the binary part.
But this function is not present in the binary part of the driver.

Actually, that was the case with 'older' release of the driver, but
seems to be reintroduced in the lastest one.

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
