Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284676AbRLPQLp>; Sun, 16 Dec 2001 11:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284687AbRLPQLf>; Sun, 16 Dec 2001 11:11:35 -0500
Received: from otter.mbay.net ([206.40.79.2]:47374 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S284676AbRLPQLa>;
	Sun, 16 Dec 2001 11:11:30 -0500
Date: Sun, 16 Dec 2001 08:10:57 -0800 (PST)
From: John Alvord <jalvo@mbay.net>
To: David Relson <relson@osagesoftware.com>
cc: lkml <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Linux 2.4.17-rc1
In-Reply-To: <4.3.2.7.2.20011216103506.00d94b90@mail.osagesoftware.com>
Message-ID: <Pine.LNX.4.20.0112160810060.7801-100000@otter.mbay.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You shouldn't fix every single defect, just the ones with wide
impact. Otherwise the rcX series could go on a long time. john

On Sun, 16 Dec 2001, David Relson wrote:

> Rik & Dave,
> 
> (as I sheepishly wipes egg off my face), guess it's time for "rc2", not 
> "final".
> 
> I guess I skipped too many lkml messages before posting mine.  'Sorry about 
> that.
> 
> David
> 
> At 09:26 AM 12/16/01, Dave Jones wrote:
> >On Sun, 16 Dec 2001, David Relson wrote:
> >
> > > IMHO, 2.4.17-rc1 seems to be ready to be promoted to 2.4.17. It's passed a
> > > suitable "release candidate" test - available for a couple of days and
> > > nobody has found any major problems.
> >
> >Except for loop deadlock, sysvfs oops, and a glut of __devexit
> >non-compiles. Whilst the sysvfs oops shouldn't affect many, loop
> >is used by a lot of people, and the __devexit patches would save
> >us another month of debian sid users who don't bother to read archives.
> >
> >regards,
> >Dave.
> >
> >--
> >| Dave Jones.        http://www.codemonkey.org.uk
> >| SuSE Labs
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

