Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbSKZXRi>; Tue, 26 Nov 2002 18:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262528AbSKZXRi>; Tue, 26 Nov 2002 18:17:38 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:16140 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261523AbSKZXRh>; Tue, 26 Nov 2002 18:17:37 -0500
Date: Tue, 26 Nov 2002 23:24:46 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Jochen Hein <jochen@jochen.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.49] atkbd.c: Unknown key [...]
In-Reply-To: <87isyodp5o.fsf@gswi1164.jochen.org>
Message-ID: <Pine.LNX.4.44.0211262323390.30451-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I use a framebuffer console.  After the screensaver kicked in pressing
> Shift gives:

Screen saver on the framebuffer console? 

> ,----
> | atkbd.c: Unknown key (set 2, scancode 0xb6, on isa0060/serio0)
> | pressed.
> `----
> 
> The same for space:
> 
> ,----
> | atkbd.c: Unknown key (set 2, scancode 0xb9, on isa0060/serio0)
> | pressed.
> `----
> 
> I didn't try other keys yet.  I'd like to get rid of these messages.

This usually means you have extra keys on your keyboard that the console 
system doesn't know.

