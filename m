Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030466AbVKPTp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbVKPTp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbVKPTp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:45:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42512 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030466AbVKPTp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:45:58 -0500
Date: Wed, 16 Nov 2005 20:45:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Scott Garfinkle <scotteglist@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/15] misc: Make x86 doublefault handling optional
Message-ID: <20051116194557.GQ5735@stusta.de>
References: <8.282480653@selenic.com> <200511160713.07632.rob@landley.net> <20051116182145.GP31287@waste.org> <f1079b100511161121g1997cfb4jc8e8aec5072c1d92@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1079b100511161121g1997cfb4jc8e8aec5072c1d92@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 01:21:48PM -0600, Scott Garfinkle wrote:

> I tend to agree with the spirit of Andi's comment -- disabling this
> will (I think) make the rare time when it happens into something
> impossible to debug without a new kernel and reproducing the problem.
> Not being familiar with EMBEDDED, I am curious whether the savings is
> critical.

menuconfig EMBEDDED
        bool "Configure standard kernel features (for small systems)"
        help
          This option allows certain base kernel options and settings
          to be disabled or tweaked. This is for specialized
          environments which can tolerate a "non-standard" kernel.
          Only use this if you really know what you are doing.

So yes, Matt's patch does make sense.

cu
Adrian

BTW: Don't strip the Cc when replying to linux-kernel.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

