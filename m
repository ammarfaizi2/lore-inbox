Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbTBBKim>; Sun, 2 Feb 2003 05:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbTBBKim>; Sun, 2 Feb 2003 05:38:42 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:60576 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265174AbTBBKil>;
	Sun, 2 Feb 2003 05:38:41 -0500
Date: Sun, 2 Feb 2003 11:47:57 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: John Bradford <john@grabjohn.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, tomita@cinet.co.jp,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.59] support japanese JP106 keyboard on new console.
Message-ID: <20030202114757.B4180@ucw.cz>
References: <20030202092346.A32354@ucw.cz> <200302021038.h12AcLKm000228@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200302021038.h12AcLKm000228@darkstar.example.net>; from john@grabjohn.com on Sun, Feb 02, 2003 at 10:38:21AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 02, 2003 at 10:38:21AM +0000, John Bradford wrote:

> > > Hiragana_Katakana was not defined before and I want to define a
> > > keycode point. 
> > > When I saw 2.4.20 pc_keyb.c source, I found all keycode below 127
> > > was used, then there is no room. But the comment tell me I can use
> > > 120-123, 125-127 with Japanese keyboard because these are not used
> > > on JP89/109 keyboards.
> > > (124 is, as you know, Yen key)  THese are defined for a latin
> > > keyboards.  So I use 120. 
> > > 
> > > How do you think about it?
> > 
> > In 2.4 you can, in 2.5 the 'as long as no duplication occurs for any
> > single keyboard' is not valid anymore, and the keycode for
> > hiragana/katakana is defined to be 183 I think.
> 
> We assigned 182 to hiragana/katakana for set 3 in 2.5, and left 183
> undefined.  Should we change the 2.5 keycode to 183?

No - just bad memory on my side, it might as well be 183. ;)

-- 
Vojtech Pavlik
SuSE Labs
