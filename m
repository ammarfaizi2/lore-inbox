Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283326AbRLDTwX>; Tue, 4 Dec 2001 14:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281664AbRLDTvO>; Tue, 4 Dec 2001 14:51:14 -0500
Received: from smtp-rt-1.wanadoo.fr ([193.252.19.151]:63436 "EHLO
	anagyris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S281450AbRLDRgM>; Tue, 4 Dec 2001 12:36:12 -0500
Message-ID: <3C0D087D.573B6174@wanadoo.fr>
Date: Tue, 04 Dec 2001 18:31:41 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre2-v199.2 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 AudioCD with cdrom modules
In-Reply-To: <3C0CC182.B65B6A52@wanadoo.fr> <200112041657.fB4GvQV06981@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Pierre Rousselet writes:
> > What may cause an AudioCD no being recognized at first attempt but
> > only after unloading/reloading the modules ide-cd cdrom ?
> >
> > I'm testing 2.5.1-pre5 + devfs-patch-v202.
> >
> > My CRD-8240B is known as /dev/cdroms/cdrom0 in fstab, to mount it
> > manually on /cdrom, and in the gnome CD player gtcd preferences panel.
> >
> > ide-cd and cdrom are loaded at boot time (i don't need that, 2.4.16 does
> > it as well). After loging in i can mount /cdrom but if it is an AudioCD
> > gtcd tells me 'no disc'.
> >
> > After rmmod ide-cd cdrom, gtcd finds the AudioCD OK.
> >
> > This doesn't happen on plain 2.4.16
> 
> Please try kernel 2.4.17-pre2 + devfs-patch-v199.2. That will help
> determine if the problem is devfs-related, or (more likely) due to the
> block I/O changes happening in 2.5.

Excellent, can you hear Diana Krall? 2.4.17-pre2 + devfs-patch-v199.2
does not have this feature. The AudioCD is identified at the first
attempt.


Pierre
-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
