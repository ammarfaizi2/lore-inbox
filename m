Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131079AbRDBRkj>; Mon, 2 Apr 2001 13:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131194AbRDBRk3>; Mon, 2 Apr 2001 13:40:29 -0400
Received: from platan.vc.cvut.cz ([147.32.240.81]:19211 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S131079AbRDBRkN>; Mon, 2 Apr 2001 13:40:13 -0400
Message-ID: <3AC8B94C.6ECE2429@vc.cvut.cz>
Date: Mon, 02 Apr 2001 10:39:24 -0700
From: Petr Vandrovec <vandrove@vc.cvut.cz>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac28-4g i686)
X-Accept-Language: cz, cs, en
MIME-Version: 1.0
To: Trevor Hemsley <Trevor-Hemsley@dial.pipex.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Matrox G400 Dualhead
In-Reply-To: <20010401000842Z129624-406+6183@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trevor Hemsley wrote:

> I get this as well on my G200. From observation it appears that the
> refresh rate is being doubled when you exit X and that's why the
> console appears blank. On my system I normally use
> 
> modprobe matroxfb vesa=263 fv=85
> 
> to give a large text console. On return from X, if I blindly type
> 
> fbset "640x480-60"
> 
> then I get a visible screen back but my monitor tells me that it's
> running at 640x480@119Hz. Same thing for 800x600-60 only this one says
> 120Hz.

Unfortunately Matrox datasheet says that it is impossible :-( Can you
try 'fbset -depth 0; fbset -depth 8' ?
						Petr
