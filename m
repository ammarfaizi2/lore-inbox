Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbSKXS32>; Sun, 24 Nov 2002 13:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbSKXS32>; Sun, 24 Nov 2002 13:29:28 -0500
Received: from r2f53.mistral.cz ([62.245.69.53]:23936 "EHLO ppc.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S261559AbSKXS31>;
	Sun, 24 Nov 2002 13:29:27 -0500
Date: Sun, 24 Nov 2002 19:36:25 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix some module format errors
Message-ID: <20021124183625.GE1542@ppc.vc.cvut.cz>
References: <200211241314.31413.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211241314.31413.tomlins@cam.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2002 at 01:14:31PM -0500, Ed Tomlinson wrote:
> This patch adds no_module_init to a few modules - those I need...
> This lets the new module code load them.

I believe that no_module_init; was vetoed... I.e. you can
have this patch in your kernel, but do not send it to Linus.
At least not matroxfb_* parts.

If no_module_init will be solution, I'll just link all matroxfb
modules together to one large object, again forgetting about
no_module_init.
				Thanks,
					Petr Vandrovec
					vandrove@vc.cvut.cz 

