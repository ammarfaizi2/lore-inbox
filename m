Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbUACOIv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 09:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbUACOIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 09:08:51 -0500
Received: from elpis.telenet-ops.be ([195.130.132.40]:10140 "EHLO
	elpis.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263330AbUACOIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 09:08:50 -0500
Date: Sat, 3 Jan 2004 15:07:55 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Paul Mundt <lethal@linux-sh.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-rc1 - Watchdog patches
Message-ID: <20040103150755.L30061@infomag.infomag.iguana.be>
References: <20040103002459.K30061@infomag.infomag.iguana.be> <20040103034541.GA5479@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040103034541.GA5479@linux-sh.org>; from lethal@linux-sh.org on Fri, Jan 02, 2004 at 10:45:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> >  drivers/char/watchdog/shwdt.c        |   14 +-
> > 
> This change is useless, it's just whitespace modification. Perhaps you may want
> to be more careful with diff in the future so you don't constantly generate
> superfluous changes. There definitely seems to be a lot of whitespace changes
> throughout the rest of these patches as well..

One of the patches was indeed: "Cleanup of trailing spaces, tabs, ...".
It's indeed not changing anything in the code, but since I am doing a 'general'
clean-up off all watchdog code, it seems only logical to me to do it properly.

Lett's assume that this extra spaces take a 100 bytes and lett's assume that
compressed we still have 20 bytes. Multiply this by the number of people that
download the kernel...

Greetings,
Wim.

