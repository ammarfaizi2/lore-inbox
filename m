Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbVKURup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVKURup (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVKURuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:50:44 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:1245 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S932432AbVKURua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:50:30 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] make miniconfig (take 2)
Date: Mon, 21 Nov 2005 11:50:16 -0600
User-Agent: KMail/1.8
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
References: <200511170629.42389.rob@landley.net> <200511211006.48289.rob@landley.net> <20051121173636.GB2642@elf.ucw.cz>
In-Reply-To: <20051121173636.GB2642@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511211150.17271.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 November 2005 11:36, Pavel Machek wrote:
> How is it supposed to work with cross-compiling.

That's why I gave the User Mode Linux example in the documentation, which 
specifies an architecture.  (And in take 2, I added an example of running the 
makemini.sh script for UML, where you have to specify ARCH=um as an 
environment variable.)

If there's more to cross-compiling than that, please tell me and I'll work it 
in.  (I know you have to specify a cross toolchain, but I didn't think that 
affected the configure step...)

>         Pavel

Rob
