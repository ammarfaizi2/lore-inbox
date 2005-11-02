Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbVKBNxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbVKBNxy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbVKBNxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:53:54 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:26040 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S965043AbVKBNxx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:53:53 -0500
Date: Wed, 2 Nov 2005 06:53:48 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [parisc-linux] [2.6 patch] parisc: "extern inline" -> "static inline"
Message-ID: <20051102135348.GI23749@parisc-linux.org>
References: <20051030000301.GO4180@stusta.de> <20051030152215.GB9235@parisc-linux.org> <Pine.LNX.4.61.0511021448010.8013@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511021448010.8013@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 02:48:42PM +0100, Jan Engelhardt wrote:
> 
> >> "extern inline" doesn't make much sense.
> 
> But GNU's ld is said to be smart enough to handle this like the 
> developerwants "extern AND inline". I did not try, though.

I think you're gravely confused.  Look at the assembly that gcc spits
out for extern inline functions.  The linker never even gets to see the
function.  Try it out, it'll be good practice for you.
