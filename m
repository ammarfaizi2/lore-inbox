Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317170AbSGTNFY>; Sat, 20 Jul 2002 09:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317277AbSGTNFY>; Sat, 20 Jul 2002 09:05:24 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:32783 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317170AbSGTNFX>; Sat, 20 Jul 2002 09:05:23 -0400
Date: Sat, 20 Jul 2002 10:07:48 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Craig Kulesa <ckulesa@as.arizona.edu>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: Re: [PATCH 6/6] Updated VM statistics patch
In-Reply-To: <Pine.LNX.4.44.0207192328330.5880-100000@loke.as.arizona.edu>
Message-ID: <Pine.LNX.4.44L.0207201006100.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002, Craig Kulesa wrote:

> This latest version takes advantage of the list management macros in
> mm_inline.h to handle all of the 'pgactivate' and 'pgdeactivate'
> counter incrementing.  This simplifies the patch, and makes it easier to
> keep accounting accurate.

Except for the fact that you'll count every new page allocation
as an activation, which isn't quite the intended behaviour ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

