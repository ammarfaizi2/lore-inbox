Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbSJIHiB>; Wed, 9 Oct 2002 03:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbSJIHiB>; Wed, 9 Oct 2002 03:38:01 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:41478 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261390AbSJIHiA>; Wed, 9 Oct 2002 03:38:00 -0400
Message-ID: <3DA3DE41.B9C218AE@aitel.hist.no>
Date: Wed, 09 Oct 2002 09:44:01 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.40mm1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Stuart Inglis <stuart@reeltwo.com>, linux-kernel@vger.kernel.org
Subject: Re: Floppy Raid
References: <002101c26e53$37df09a0$2a01410a@nz.reeltwo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart Inglis wrote:
> 
> Hi all,
> 
> I've been playing with RAID over floppy (2x3.5" /dev/fd0, /dev/fd1) and
> have a few questions. (With 2.4.18)
> 
> It seems clear that you can only read/write to one floppy device at a
> time. Is this a hardware limit or a linux limit? fdformat to a single
> drive takes around 100 seconds, whereas running two fdformats in
> parallel takes close to 400 seconds (2.4.18). It looks like this is
> because the lock changes when the fdformat switches from writing to
> verifying.

Hardware limit _if_ you have two pc floppies on the same cable.
Use separate floppy controllers if you want simultaneous
access.  That worked fine for me back in 1992 or so.

The relieblility of floppies makes me hope you're going
for raid-1 and not raid-0...

Helge Hafting
