Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTDWXfw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 19:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264309AbTDWXfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 19:35:52 -0400
Received: from fmr01.intel.com ([192.55.52.18]:19955 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263467AbTDWXfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 19:35:51 -0400
Message-ID: <F760B14C9561B941B89469F59BA3A847E96E0E@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Marc Giger <gigerstyle@gmx.ch>
Cc: Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: RE: Fix SWSUSP & !SWAP
Date: Wed, 23 Apr 2003 16:47:52 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Martin J. Bligh [mailto:mbligh@aracnet.com] 
> Can't you just create a pre-reserved separate swsusp area on 
> disk the size 
> of RAM (maybe a partition rather than a file to make things 
> easier), and 
> then you know you're safe (basically what Marc was 
> suggesting, except pre-allocated)? Or does that make me the 
> prince of all evil? ;-)
> 
> However much swap space you allocate, it can always all be 
> used, so that seems futile ...

This is what Other OSes do, and I believe this is the correct path.
Using swap for swsusp is a clever hack but not a 100% solution.

-- Andy
