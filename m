Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262803AbTCQFsv>; Mon, 17 Mar 2003 00:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262804AbTCQFsu>; Mon, 17 Mar 2003 00:48:50 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:46597 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S262803AbTCQFsu>;
	Mon, 17 Mar 2003 00:48:50 -0500
Date: Mon, 17 Mar 2003 06:57:27 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Toplica Tanaskovic <toptan@EUnet.yu>
Cc: Sheng Long Gradilla <skamoelf@netscape.net>, linux-kernel@vger.kernel.org
Subject: Re: AGP 3.0 for 2.4.21-pre5
Message-ID: <20030317055727.GA26167@alpha.home.local>
References: <200303151816.39915.toptan@EUnet.yu> <3E74AC3B.6070404@netscape.net> <200303170008.41525.toptan@EUnet.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303170008.41525.toptan@EUnet.yu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 12:08:41AM +0100, Toplica Tanaskovic wrote:
>You have to run make clean first, or faster way go to drivers/char/agp/ and
> delete any .o files, and then do make modules...
> 
>I'll have to figure out way to force compilation of agpgart if only agp 3.0 
> menu item was changed.

Well, you can apply your make to the agp directory only if needed :
# make clean SUBDIRS=drivers/char/agp
# make modules SUBDIRS=drivers/char/agp

I often use this, it's very convenient.

Cheers,
Willy
