Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130355AbQKVQ2k>; Wed, 22 Nov 2000 11:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132129AbQKVQ2b>; Wed, 22 Nov 2000 11:28:31 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:28226 "EHLO
        amsmta03-svc.chello.nl") by vger.kernel.org with ESMTP
        id <S130355AbQKVQ2Q>; Wed, 22 Nov 2000 11:28:16 -0500
Date: Wed, 22 Nov 2000 18:05:53 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Daniel Stone <daniel@kabuki.eyep.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Rik's bad process killer - how to kill _IT_?
In-Reply-To: <20001122123115Z129851-8303+80@vger.kernel.org>
Message-ID: <Pine.LNX.4.21.0011221805070.27178-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000, Daniel Stone wrote:

> Hi,
> I've been having a bit of a problem with Rik's new VM, in particular the bad
> process-killer. Basically put, I have a reasonably underpowered system
> (P166) running Helix GNOME & Sawfish, and half the time when I load my Eterm
> (admittedly, transparent, but it looks cool, damnit!), or Netscape (or
> both!) it seems to be Rik's VM killer slaying them. No error message is
> logged anywhere, not even if I start 'em from the console.
> Is there a /proc hack or something?
> Thanks a lot!

This is NOT the OOM killer. It always logs / sends messages to the
console. The app probably just segfaults.


> :) d


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
