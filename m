Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288047AbSA2C3U>; Mon, 28 Jan 2002 21:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288411AbSA2C3B>; Mon, 28 Jan 2002 21:29:01 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:33568 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S288047AbSA2C2z>; Mon, 28 Jan 2002 21:28:55 -0500
Date: Tue, 29 Jan 2002 13:55:18 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Doug Ledford <dledford@redhat.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] i810 driver update.
In-Reply-To: <3C5603D9.3070608@redhat.com>
Message-ID: <Pine.LNX.4.05.10201291348590.1513-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Doug Ledford wrote:

[...]
> > Are the fixes in this going to be applicable to 2.2 also (FWIW, 2.2's
> > i810_audio #defines ``DRIVER_VERSION "0.17"'')?
> 
> 
> I'm sure the fixes are relevant.  How well they may integrate into 2.2 is 
> another question :-/

Indeed ;-)  Alan?
[...]
> The best I can do it to make a diff between the 0.17 driver version I have 
> here and the 0.21 driver version.  Maybe that incremental diff will apply to 
> the 2.2 kernel's i810_audio.c and bring it up to date without any specific 
> back port needed.  It's attached.

Thanks anyway, but it doesn't look too hopeful (patch complaints
appended).  I suspect your "0.17" and 2.2's "0.17" may not be the same
thing (in 2.2.21pre2 i810_audio.c is 51877 bytes and "sum (GNU textutils)  
2.0" reports "44467 51"

Regards,
Neale.

$ patch --dry-run < 2.2-i810.patch 
patching file `i810_audio.c.17'
Hunk #1 succeeded at 181 (offset -25 lines).
Hunk #2 FAILED at 576.
Hunk #3 FAILED at 653.
Hunk #4 FAILED at 1107.
Hunk #5 FAILED at 1117.
Hunk #6 FAILED at 1138.
Hunk #7 FAILED at 1169.
Hunk #8 succeeded at 1127 with fuzz 1 (offset -248 lines).
Hunk #9 FAILED at 1278.
Hunk #10 FAILED at 1492.
Hunk #11 FAILED at 2175.
Hunk #12 FAILED at 2877.
10 out of 12 hunks FAILED -- saving rejects to i810_audio.c.17.rej

