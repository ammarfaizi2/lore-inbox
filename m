Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132867AbRDPHAH>; Mon, 16 Apr 2001 03:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132868AbRDPG75>; Mon, 16 Apr 2001 02:59:57 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:5640 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132867AbRDPG7j>; Mon, 16 Apr 2001 02:59:39 -0400
Message-ID: <3ADA9853.AA79BDB5@transmeta.com>
Date: Sun, 15 Apr 2001 23:59:31 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Unisys pc keyboard new keys patch, kernel 2.4.3
In-Reply-To: <200104160654.f3G6sHu477292@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:
> 
> H. Peter Anvin writes:
> 
> > This means you don't have to configure two levels (scancodes ->
> > keycodes and keycodes -> keymap); since currently the keycodes are
> > keyboard-specific anyway there is no benefit to the two levels.
> 
> The medium-raw level ought to be what the X11R6 protocol uses.
> Then the keyboard-specific stuff can be removed from XFree86,
> and there would be one less mapping to configure.
> 

Uhm, doesn't work that way.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
