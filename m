Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965201AbVHTALg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbVHTALg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 20:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbVHTALg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 20:11:36 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:38800 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S965201AbVHTALg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 20:11:36 -0400
Message-ID: <43067527.1000708@tremplin-utc.net>
Date: Sat, 20 Aug 2005 02:11:19 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0.6-3mdk (X11/20050322)
X-Accept-Language: en, fr, ja, es
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: VIA USB Controller - (Wrong ID) ??
References: <9a8748490508191153512e2db4@mail.gmail.com>
In-Reply-To: <9a8748490508191153512e2db4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

19.08.2005 20:53, Jesper Juhl wrote/a écrit:
> I've just noticed that my USB controller(s) show up as having "Wrong
> ID" and now I'm wondering what exactely that means and what I can do
> about it  (kernel 2.6.13-rc6-mm1 in case it matters).
> 
> Is it a wrong PCI ID? If so, how's the controller recognized at all?
> 
> I stopped by http://pci-ids.ucw.cz/iii// which had an entry saying :
> 
> 0925	VIA Technologies, Inc. (Wrong ID)
>     	Wrong ID used in subsystem ID of VIA USB controllers.
> 
I've never heard of this before. However, cheking the list shows that 
every vendor which has a "Wrong ID" entry also a normal one. So my guess 
is that "wrong ID" means that somewhere in the process of putting the 
PCI ID (during the design of the device) someone mistook which ID to 
put. So this would mean that your device doesn't have the official ID of 
VIA, but it uses an unofficial one (famous enough to be listed though). 
Nothing to worry about.

:
> 00:04.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0
> controller] (rev 16) (prog-if 00 [UHCI])
>         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller

> 
> Can anyone explain this to me?     The controllers are working just
> fine, so it's not too important, I'm just a currious nature :)

Well, as I said before, it's just pure guess, but it's cool to invent 
stories ;-)

Eric

