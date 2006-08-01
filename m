Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030407AbWHACrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbWHACrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 22:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWHACrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 22:47:11 -0400
Received: from terminus.zytor.com ([192.83.249.54]:59283 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030407AbWHACrK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 22:47:10 -0400
Message-ID: <44CEC0A1.6020705@zytor.com>
Date: Mon, 31 Jul 2006 19:46:57 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86_64 built-in command line
References: <20060731171442.GI6908@waste.org> <200607312207.58999.ak@suse.de> <44CE6AEA.2090909@zytor.com> <200608010017.00826.ak@suse.de> <20060801014319.GO6908@waste.org> <44CEBEAF.8030203@zytor.com> <20060801024102.GS6908@waste.org>
In-Reply-To: <20060801024102.GS6908@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> 
> That idea doesn't suck. I'll take a look at it.
> 
> We still have a problem with overriding things like console=tty, for
> which there's no obvious fix that doesn't break the world.
> 

One could define "console=" (empty argument) as a command to reset the 
list.  It probably would be useful.

	-hpa
