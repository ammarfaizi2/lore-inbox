Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135783AbRDYOSP>; Wed, 25 Apr 2001 10:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135854AbRDYOSF>; Wed, 25 Apr 2001 10:18:05 -0400
Received: from stanis.onastick.net ([207.96.1.49]:47373 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S135783AbRDYOR5>; Wed, 25 Apr 2001 10:17:57 -0400
Date: Wed, 25 Apr 2001 10:17:55 -0400
From: Disconnect <lkml@sigkill.net>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
Message-ID: <20010425101755.B26050@sigkill.net>
In-Reply-To: <20010425103456.D11099@piro.kabuki.openfridge.net> <Pine.LNX.4.10.10104241751010.6846-100000@innerfire.net> <20010425094625.I20175@tux.bitfreak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010425094625.I20175@tux.bitfreak.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2001, Ronald Bultje did have cause to say:

> Who says it needs to compile? Who says it needs software installed? Who
> says it needs to run the software itself?

My current project (and I'm just waiting for nfs and wvlan_cs to stabalize
on ARM before putting the final touches on it) is an ipaq nfsrooted to a
Debian image, over the wireless lan.  Works like a champ, and it -does-
compile stuff reasonably fast (well, reasonably fast considering the data
is all on the far side of 11M/sec wireless.)  My kit is mostly portable as
well, since the nfs server is on the libretto and runs just fine in my
backpack ;)

The next step is bludgeoning debian-arm into not running 50-100 little
servers I don't need on my PIM.  But that may be the function of a
task-nfs-ipaq package or some such.

So far -multiuser- linux on PIMs ("true" linux, with X, etc, as distinct
from pocketlinux/qpe/etc, which are a different animal in this case) is
almost there.  Web browsers are coming along nicely (and remote-X netscape
is usable, although barely) and there are several nice imap clients. (and
input methods ranging from a handwriting system to a little onscreen
keyboard, if you are in a situation where an external keyboard is not
feasable.)

---
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P- L+++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t
5--- X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
