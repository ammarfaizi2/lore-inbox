Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUBOW03 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 17:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbUBOW03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 17:26:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:54430 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265232AbUBOW01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 17:26:27 -0500
Subject: Re: 2.6.3-rc3: radeon blanks screen
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <402F83D4.3080605@oracle.com>
References: <402F83D4.3080605@oracle.com>
Content-Type: text/plain
Message-Id: <1076883902.6959.100.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 09:25:04 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-16 at 01:36, Alessandro Suardi wrote:
> On my Dell Latitude C640 as on Peter Osterlund's laptop - blind-typing
>   login/password and startx gets me a visible X desktop.
> 
> Old driver with Peter's patch works as before.
> 
> Note - this is the same laptop you tried I gave up using framebuffer on
>   in the 2.4 series because after 2.4.22-pre4 it would send my screen in
>   a crazed-up state (X didn't work either) [that was July 2003].

Please enable the #define DEBUG 1 in radeonfb.h  and send me the
output  again.

Ben.


