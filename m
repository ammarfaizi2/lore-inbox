Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbWFZBg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWFZBg7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWFZBg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:36:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31369 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964981AbWFZBg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 21:36:59 -0400
Date: Sun, 25 Jun 2006 18:36:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Shaohua Li <shaohua.li@intel.com>, Pavel Machek <pavel@ucw.cz>,
       Nigel Cunningham <nigel@suspend2.net>, Andrew Morton <akpm@osdl.org>,
       Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Subject: Re: [PATCH] swsusp: add architecture special saveable pages support
In-Reply-To: <20060626011424.GA16497@redhat.com>
Message-ID: <Pine.LNX.4.64.0606251819510.3747@g5.osdl.org>
References: <200606231501.k5NF1WvU004659@hera.kernel.org>
 <20060626011424.GA16497@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Jun 2006, Dave Jones wrote:
> 
> This breaks PPC compiles for me.

Well, since Daniel Ritz reported that the following patch (that that patch 
was done in support of) also caused problems, I think we'll just have to 
revert that whole series. It's clearly not fully cooked.

		Linus
