Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313818AbSD0Ns4>; Sat, 27 Apr 2002 09:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314058AbSD0Nsz>; Sat, 27 Apr 2002 09:48:55 -0400
Received: from ns1.baby-dragons.com ([199.33.245.254]:38379 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S313818AbSD0Nsy>; Sat, 27 Apr 2002 09:48:54 -0400
Date: Sat, 27 Apr 2002 09:48:37 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.x-dj and SCSI error handling.
In-Reply-To: <20020427131025.F14743@suse.de>
Message-ID: <Pine.LNX.4.44.0204270947250.5500-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Dave ,  Might be nice to also mention the drivers that were
	being complained about .  So there respective mantainers can
	benifit from your email .  Tia ,  JimL

On Sat, 27 Apr 2002, Dave Jones wrote:

> Folks, I just woke up to about a dozen reports of the same 'bug'
> all with patches which are so wrong they stand no chance of application
> by me or Linus, posting here is quicker than me pointing those people
> (and those who may follow them) to the answer.
>
> The recent patch from Christoph Hellwig which kills off
> the last remaining remnants of the old style SCSI error handling.
> The reason these drivers no longer compile due to missing 'abort' and
> 'reset' functions is due to the fact that they need converting to
> new-style error handling.
>
> For instructions on how to do this, read http://www.andante.org/scsi_eh.html
>
> For instructions on how not to this..
> o   Do not send me patches that just remove the reset: and abort:
>     functions. This gives us no error handling whatsoever.
> o   Do not send me patches re-adding the 'missing' reset & abort functions
>     to the Scsi_Host_Template struct.  This gets us nowhere.
> o   Yes, I know ide-scsi, and various other scsi drivers are broken.
>     Fix them, or be patient and wait for them to be fixed.
>     Dave.

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

