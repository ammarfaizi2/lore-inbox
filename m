Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbTAYP3k>; Sat, 25 Jan 2003 10:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbTAYP3k>; Sat, 25 Jan 2003 10:29:40 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:10183 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261799AbTAYP3j>;
	Sat, 25 Jan 2003 10:29:39 -0500
Date: Sat, 25 Jan 2003 16:36:53 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Hiroshi Miura <miura@da-cha.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.59] support japanese JP106 keyboard on new console.
Message-ID: <20030125163653.A8207@ucw.cz>
References: <20030124031453.0A29F11775F@triton2> <20030124065741.B19571@ucw.cz> <3E3171FC.FE9139CE@cinet.co.jp> <20030125113324.D28292@ucw.cz> <3E32AD4B.403FA43D@cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E32AD4B.403FA43D@cinet.co.jp>; from tomita@cinet.co.jp on Sun, Jan 26, 2003 at 12:29:15AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2003 at 12:29:15AM +0900, Osamu Tomita wrote:

> > Well, it's not so easy. Fortunately KEY_KPCOMMA can be relatively easily
> > moved elsewhere, however keys 181 to 198 are 'international and language
> > keys', defined the same way as USB/HID spec (please take a look at it).
> > Having a single one of them remapped elsewhere doesn't look so nice.
> > 
> > --
> > Vojtech Pavlik
> > SuSE Labs

> Thanks. I see. Keycode in the kernel should be unified.

Definitely. And cast in stone and never changed again.

> I'll use newer kbd utility (kbd-1.08) and rewrite keymap like below.
>  keycode 124 = backslash	bar	#Compatibility for 2.4 (for a while)
>  keycode 183 = backslash	bar

Yes, that'd be great.

> BTW. I've extracted japanese keyboard specification from OADG's documents.
> About OADG, please visit http://www.oadg.org/.
> I attach those files. Usefull?

Yes, I'm sure they'll be.

-- 
Vojtech Pavlik
SuSE Labs
