Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317578AbSGYEcK>; Thu, 25 Jul 2002 00:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSGYEcK>; Thu, 25 Jul 2002 00:32:10 -0400
Received: from tomts15.bellnexxia.net ([209.226.175.3]:53416 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S317578AbSGYEcJ>; Thu, 25 Jul 2002 00:32:09 -0400
User-Agent: Pan/0.11.2 (Unix)
From: "David Caplan" <david@david.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: Asus-a7v/Via-Vt8233 data corruption
Date: Thu, 25 Jul 2002 00:35:21 -0400
References: <20020721043653.NLID8251.tomts6-srv.bellnexxia.net@david> <Pine.LNX.4.44.0207242115330.31655-100000@freak.distro.conectiva>
Message-Id: <20020725043515.YEEX6014.tomts15-srv.bellnexxia.net@apple>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002 21:20:08 -0400, Marcelo Tosatti wrote:


> Could you, David, and other people with corruption try this patch from
> Andre?
> 


Hi,

I did some more testing, and to my great surprise found that one of my 
ram sticks was dead. This is what seems to have been causing the
corruption.

Hopefully (because I just re-installed) it won't corrupt any more,
but I will still try out this patch. This patch looks like it fixes the
VIA 8367, which is on the Asus A7V333 board, not the a7v266 (my) board.
However, coincidentally I happen to be receiving the A7V333 board 
tomorow :) So I will test the patch when I install the new board.

For the other people with the corruption, did you alter the pci latency 
in the bios? 

- David
