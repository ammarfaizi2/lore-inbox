Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbVHGWs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbVHGWs0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 18:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbVHGWs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 18:48:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52453 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751551AbVHGWsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 18:48:25 -0400
Date: Mon, 8 Aug 2005 00:48:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux@dominikbrodowski.net
Subject: Re: 2.6.13-rc4: yenta_socket and swsusp
Message-ID: <20050807224821.GG3100@elf.ucw.cz>
References: <42EE9A60.5050700@domdv.de> <20050804171514.01028a67.akpm@osdl.org> <42F68098.5010203@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F68098.5010203@domdv.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 2. The attached script can produce all sorts of pcmcia related
>    problems if it is modified where stated - the attached version
>    seems to work without problems if not modified. Do you want
>    a bug report filed for this, too?

Races in pcmcia, fun :-(. I guess this is going to be slightly hard to
reproduce without right hardware :(.
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
