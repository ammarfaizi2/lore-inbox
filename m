Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312687AbSDSOvb>; Fri, 19 Apr 2002 10:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312690AbSDSOva>; Fri, 19 Apr 2002 10:51:30 -0400
Received: from fluent1.pyramid.net ([206.100.220.212]:60979 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S312687AbSDSOva>; Fri, 19 Apr 2002 10:51:30 -0400
Message-Id: <5.1.0.14.0.20020419074625.00a7a900@10.1.1.42>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 19 Apr 2002 07:50:57 -0700
To: Kent Borg <kentborg@borg.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: Re: A CD with errors (scratches etc.) blocks the whole system
  while reading damaged files
Cc: "Dr. Death" <drd@homeworld.ath.cx>, linux-kernel@vger.kernel.org
In-Reply-To: <20020419102219.E21727@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:22 AM 4/19/02 -0400, Kent Borg wrote:
> > > Problem:
> > >
> > > I use SuSE Linux 7.2 and when I create md5sums from damaged files on a
> > > CD, the WHOLE system  freezes or is ugly slow untill md5 has passed the
> > > damaged part of the file !
> > >
> >
> > So what do you suggest? You can see from the logs that the device
> > is having difficulty  reading your damaged CD. You can do what
> > Windows-95 does (ignore the errors and pretend everything is fine),
> > or what Windows-98 and Windows-2000/Prof does (blue-screen, and re-boot),
> > or you can try like hell to read the files like Linux does. What do you
> > suggest?
>
>You didn't ask me, but I would still suggest that it would be nice if
>the whole system didn't come to a near halt.

If that is a real concern, then consider moving from a 56x CD-ROM reader to 
something considerably slower, like a 4x or 8x.  (Or try modifying the 
driver to request a slower speed.)  That will reduce the flood of I/O 
messages and actions performed by the driver to recover from 
badly-scratched media.

Another option is to invest in a good scratch-repair kit -- many scratches 
can be filled with appropriate material that reduces the optical distortion 
that causes the flood of activity in the first place.

Do you have a CD burner?  Then extract the data and burn a new CD.

Finally, try investing in a CD-ROM player that has in-drive smarts to 
recover from scratched media.

The choice is your.


