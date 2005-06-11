Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVFKRY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVFKRY3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 13:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVFKRY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 13:24:29 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:20492 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261751AbVFKRYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 13:24:25 -0400
Date: Sat, 11 Jun 2005 19:24:19 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Assuming NULL
Message-ID: <20050611172419.GE28759@alpha.home.local>
References: <Pine.LNX.4.61.0506111823440.19223@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506111823440.19223@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Sat, Jun 11, 2005 at 06:24:22PM +0200, Jan Engelhardt wrote:
(...)
> My question is: Which one is right wrt the case "i_op ==/!= NULL"?
> There are two ways:
> 
> - the kernel assumes i_op (and similar) is always non-NULL
>   => then we can remove a lot of checks, like the first example above
> 
> - the kernel does not assume...
>   => then we need some extra checks, like in the second example above

and in any case, adding a comment telling why it CAN or why it CANNOT
be NULL would prevent other people from having to redo the same work
in 6 months.

Willy

