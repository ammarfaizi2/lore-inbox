Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbSJ3JMs>; Wed, 30 Oct 2002 04:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264632AbSJ3JMr>; Wed, 30 Oct 2002 04:12:47 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:38562 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264630AbSJ3JMr>; Wed, 30 Oct 2002 04:12:47 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: andersen@codepoet.org, Dave Cinege <dcinege@psychosis.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
References: <200210272017.56147.landley@trommello.org>
	<200210300229.44865.dcinege@psychosis.com>
	<3DBF8CD5.1030306@pobox.com>
	<200210300322.17933.dcinege@psychosis.com>
	<20021030085149.GA7919@codepoet.org>
	<buofzuogv31.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<3DBFA0F8.9000408@pobox.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 30 Oct 2002 18:19:07 +0900
In-Reply-To: <3DBFA0F8.9000408@pobox.com>
Message-ID: <buobs5cgu7o.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:
> >[Well, OK, actually it'd be nice to have something like initramfs + some
> >other sort of fetch-the-bits-directly-from-ROM FS which I could
> >mix-n-match; anyway initramfs has got to be better than initrd...]
> 
> It should be pretty easy to populate initramfs from ROM...

Actually what I was trying to say was that often I don't want to copy
from ROM to RAM, I just want to have file reads get the bits directly
from ROM (to avoid using, um, RAM).

Currently I do this by using a romfs filesystem stored in an MD device
which is reading from ROM.

-Miles
-- 
[|nurgle|]  ddt- demonic? so quake will have an evil kinda setting? one that 
            will  make every christian in the world foamm at the mouth? 
[iddt]      nurg, that's the goal 
