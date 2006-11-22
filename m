Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755917AbWKVOCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917AbWKVOCA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 09:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755921AbWKVOCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 09:02:00 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:12242 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1755917AbWKVOB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 09:01:59 -0500
Message-ID: <456457F4.8060705@gmail.com>
Date: Wed, 22 Nov 2006 15:00:20 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: Ram <vshrirama@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: USB Mouse does not work, please advice
References: <8bf247760611200316y761fa18dg4bdfc55e90b70309@mail.gmail.com> <45619678.5070400@gmail.com> <8bf247760611220419i1545352cvc3316562b8b53ce0@mail.gmail.com> <200611221355.46214.oliver@neukum.org>
In-Reply-To: <200611221355.46214.oliver@neukum.org>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Am Mittwoch, 22. November 2006 13:19 schrieb Ram:
>> The Handler field has only event0, But my mouse is not working?.
>>
>>
>> If i do cat /dev/input/event0. Im able to see characters when i move
>> the mouse, Im also getting interrupts.
>>
>> However, When i run XfbDev and move the mouse, the 'X' mark at the
>> centre does not move.
>>
>>
>> Am i missing something?.
> 
> If you only got event as handler X must be set up to use input events.
> Which drivers have you loaded?

Exactly, use evdev driver in your X conf. I'm just confused, why you didn't get
input/mouseX handler. Is it self-configured vanilla or a distro kernel?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
