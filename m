Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbTBBK2K>; Sun, 2 Feb 2003 05:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbTBBK2K>; Sun, 2 Feb 2003 05:28:10 -0500
Received: from [81.2.122.30] ([81.2.122.30]:10500 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265171AbTBBK2K>;
	Sun, 2 Feb 2003 05:28:10 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302021038.h12AcLKm000228@darkstar.example.net>
Subject: Re: [PATCH 2.5.59] support japanese JP106 keyboard on new console.
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Sun, 2 Feb 2003 10:38:21 +0000 (GMT)
Cc: tomita@cinet.co.jp, linux-kernel@vger.kernel.org
In-Reply-To: <20030202092346.A32354@ucw.cz> from "Vojtech Pavlik" at Feb 02, 2003 09:23:46 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hiragana_Katakana was not defined before and I want to define a
> > keycode point. 
> > When I saw 2.4.20 pc_keyb.c source, I found all keycode below 127
> > was used, then there is no room. But the comment tell me I can use
> > 120-123, 125-127 with Japanese keyboard because these are not used
> > on JP89/109 keyboards.
> > (124 is, as you know, Yen key)  THese are defined for a latin
> > keyboards.  So I use 120. 
> > 
> > How do you think about it?
> 
> In 2.4 you can, in 2.5 the 'as long as no duplication occurs for any
> single keyboard' is not valid anymore, and the keycode for
> hiragana/katakana is defined to be 183 I think.

We assigned 182 to hiragana/katakana for set 3 in 2.5, and left 183
undefined.  Should we change the 2.5 keycode to 183?

John.
