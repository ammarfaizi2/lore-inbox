Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932646AbWBYRQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbWBYRQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 12:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbWBYRQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 12:16:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46812 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932625AbWBYRQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 12:16:24 -0500
Message-ID: <44009024.5050105@osdl.org>
Date: Sat, 25 Feb 2006 09:13:08 -0800
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
References: <20060225160150.GX3674@stusta.de>
In-Reply-To: <20060225160150.GX3674@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> CONFIG_UNIX=m doesn't make much sense.
>
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
>
>   
Why? You can build unix domain sockets as a loadable module and
it runs fine (or it did last I tried). Whether that makes sense from a 
distribution point of
view, because everybody wants it, is another story.

