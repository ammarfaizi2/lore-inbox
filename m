Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133110AbRDMBdp>; Thu, 12 Apr 2001 21:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133112AbRDMBde>; Thu, 12 Apr 2001 21:33:34 -0400
Received: from gear.torque.net ([204.138.244.1]:10756 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S133110AbRDMBdS>;
	Thu, 12 Apr 2001 21:33:18 -0400
Message-ID: <3AD65738.A0056C99@torque.net>
Date: Thu, 12 Apr 2001 21:32:40 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Tim Meushaw <meushaw@pobox.com>
Subject: Re: Problem with 2.4.1/2.4.3 and CD-RW ide-scsi drive
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Meushaw <meushaw@pobox.com> wrote:
> I've got an update for this problem I emailled about 
> last night (and for which I only received one reply :-) ).
>
> Strangely enough, I'm able to actually burn a CD 
> using the cd-rw described below, and can verify 
> data written to it (using X-CD-Roast). I still can't 
> actually mount a cd in the drive without getting the 
> error described below, but at least I can burn CDs now.
> 
> Does this behavior sound like a kernel problem, or 
> does it suggest a bug in the 'mount' utility?

Tim,
At the risk of Jens jumping on this post, I think
there was some problem mounting cdroms that is
fixed in the "ac" series, the latest of which is
2.4.3-ac5 . Perhaps you could try it and report
back.

The fact that you can write a cd (which does not
involve the sr driver) means that the rest of the SCSI
subsystem and the ide-scsi driver seem to be working
ok. I doubt that this is a problem with the mount
command.

Doug Gilbert
