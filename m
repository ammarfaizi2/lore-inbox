Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbWHACmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWHACmS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 22:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbWHACmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 22:42:18 -0400
Received: from waste.org ([66.93.16.53]:5804 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030400AbWHACmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 22:42:17 -0400
Date: Mon, 31 Jul 2006 21:41:02 -0500
From: Matt Mackall <mpm@selenic.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86_64 built-in command line
Message-ID: <20060801024102.GS6908@waste.org>
References: <20060731171442.GI6908@waste.org> <200607312207.58999.ak@suse.de> <44CE6AEA.2090909@zytor.com> <200608010017.00826.ak@suse.de> <20060801014319.GO6908@waste.org> <44CEBEAF.8030203@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CEBEAF.8030203@zytor.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 07:38:39PM -0700, H. Peter Anvin wrote:
> Actually, the best thing to do might be to designate a symbol (say &, 
> like in automount) as "insert the boot loader command line here."
> 
> That way you can specify things in the builtin command line that are 
> both prepended and appended to the boot loader command, and if you wish, 
> you can emit it completely.
> 
> The default would be just "&".

That idea doesn't suck. I'll take a look at it.

We still have a problem with overriding things like console=tty, for
which there's no obvious fix that doesn't break the world.

-- 
Mathematics is the supreme nostalgia of our time.
