Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262674AbREOIW1>; Tue, 15 May 2001 04:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262675AbREOIWS>; Tue, 15 May 2001 04:22:18 -0400
Received: from [62.172.234.2] ([62.172.234.2]:5249 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S262674AbREOIWB>;
	Tue, 15 May 2001 04:22:01 -0400
Date: Tue, 15 May 2001 09:21:47 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
To: Blesson Paul <blessonpaul@usa.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: dget()
In-Reply-To: <20010515080939.11641.qmail@nw174.netaddress.usa.net>
Message-ID: <Pine.LNX.4.21.0105150919580.1454-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 May 2001, Blesson Paul wrote:
>              In everyfile system, dget() function is called. But I cannot find
> where is the dget() function is written. Where is it

To find this out, you type:

# vi -t dget

and then look at the bottom line which would show
"./include/linux/dcache.h"

This assumes you have built the tags by:

# cd /usr/src/linux
# find -name '*.[ch]' | ctags -L- &
# echo "set tags=tags" >> .vimrc

And, btw, it is a static inline, not a function per se.

Regards,
Tigran

