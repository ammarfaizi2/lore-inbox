Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278437AbRJZLzj>; Fri, 26 Oct 2001 07:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278449AbRJZLz3>; Fri, 26 Oct 2001 07:55:29 -0400
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:59625 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S278447AbRJZLzT> convert rfc822-to-8bit; Fri, 26 Oct 2001 07:55:19 -0400
Date: Fri, 26 Oct 2001 07:58:48 -0400 (EDT)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Nate Dannenberg <natedac@kscable.com>, livid-gatos@linuxvideo.org,
        video4linux-list@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [livid-gatos] [RFC] alternative kernel multimedia API
In-Reply-To: <1004092530.10130.145.camel@nomade>
Message-ID: <Pine.LNX.4.20.0110260757190.10883-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 26 Oct 2001, Xavier Bestel wrote:

> le ven 26-10-2001 à 01:14, volodya@mindspring.com a écrit :
> 
> > >  05,HUE=7\n
> > >  07,some unrelated command
> > > +05\n				# The HUE command was successful
> > > :07,reply to unrelated command
> > > :05,HUE=6\n			# Driver reported the HUE parameter as
> 
> I would prefer a proc-like interface to devices, e.g.:
> 
> /dev/video0/hue
> /dev/video0/saturation
> ...
> 
> more unix-like, no parsing involved.

This would be a problem as an application would need to open many files in
order to operate such interface. Additionally, you underestimate the
number of files needed. We'll need hue_range, hue_label, hue_comment and
something else..

Parsing is not that hard I believe.

                        Vladimir Dergachev

> 
> 	Xav
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

