Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTJBUG3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 16:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbTJBUG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 16:06:29 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:42380 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id S263464AbTJBUG2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 16:06:28 -0400
Date: Thu, 2 Oct 2003 21:05:59 +0100 (IST)
From: James Stevenson <james@stev.org>
To: Takashi Iwai <tiwai@suse.de>
cc: Kees Bakker <kees.bakker@xs4all.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test6] Scratchy sound with via82xx (VT8233)
In-Reply-To: <s5h7k3o0x8b.wl@alsa2.suse.de>
Message-ID: <Pine.LNX.4.44.0310022105400.26790-100000@god.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > I saw the note about dxs_support, but I have the driver built-in. How do I set
> > dxs_support from the /proc/cmdline?
> 
> pass via boot parameter:
> 
>   snd-via82xx=1,0,,-1,48000,XXX
> 
> where XXX is the value from 0 to 3 for dxs_support.
> see the comment in sound/via82xx.c.


will this work for a 2.4.x kernel as well ?



