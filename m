Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271922AbTHDQlU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 12:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271924AbTHDQlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 12:41:20 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:37276 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271922AbTHDQlT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 12:41:19 -0400
Subject: Re: time jumps (again)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Patrick Moor <pmoor@netpeople.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F2E8B3B.3070003@netpeople.ch>
References: <3F2E8B3B.3070003@netpeople.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060015049.719.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Aug 2003 17:37:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-08-04 at 17:35, Patrick Moor wrote:
> few years! Uptime of the machine is now 218 days, and problems began 
> appearing after 215 days approximately.

Not sure why 215 days should be significant

> What happens: when doing a
>   $ while true; do date; done
> I'm noticing time jumps _exactly_ at the beginning of a "new" second (or 
> at the end of an "old" one). the jump is exactly 4294 (4295) seconds 
> into the future. Example:

4294.. top of -1

Smells of some kind of sign propogation bug

