Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbVCQLva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbVCQLva (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 06:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbVCQLv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:51:26 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:35086 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S263061AbVCQLGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 06:06:04 -0500
Message-ID: <42396569.6040509@aitel.hist.no>
Date: Thu, 17 Mar 2005 12:09:29 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Andrew Morton <akpm@osdl.org>, dtor_core@ameritech.net,
       dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3 mouse oddity
References: <20050312034222.12a264c4.akpm@osdl.org> <4236D428.4080403@aitel.hist.no> <d120d50005031506252c64b5d2@mail.gmail.com> <20050315110146.4b0c5431.akpm@osdl.org> <4237FFE4.4030100@aitel.hist.no> <20050316173054.GD1608@ucw.cz>
In-Reply-To: <20050316173054.GD1608@ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>On Wed, Mar 16, 2005 at 10:44:04AM +0100, Helge Hafting wrote:
>
>  
>
>>The logitech cordless keyboard is one.  It has two wheels.
>>The one on the side works generates up-arrow/down arrow when used,
>>and now also events on /dev/mouse0.  The other is a wheel above
>>the keys, lying on the side.  Logitech apparently meant it to be used as
>>a volume control, which should be possible now that it attaches to
>>/dev/mouse0.
>>    
>>
>
>Can you please check with 'evtest' that both the wheels work correctly?
>
>  
>
Not sure what is correct here, but:
evtest /dev/input/event0 produce events for all keys on the keyboard.
Both the normal pc-105 keys, silly extra keys like "favourites", "shopping",
etc., and the wheels.  The "volume" wheel generates VolumeUp and
VolumeDown keypresses (and releases.) The other wheels generates
the same events as the up-arrow and down-arrow keys.

evtest on /dev/input/event1 gives me events from the mouse.
mouse0, mouse1 and mouse2 cannot be used with evtest.

>Also, there exists an event mouse driver for X which supports both
>wheels and allows for vertical and horizontal scrolling in eg. Firefox.
>  
>
Helge Hafting
