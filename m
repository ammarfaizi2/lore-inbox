Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272253AbRIOMGt>; Sat, 15 Sep 2001 08:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272262AbRIOMG3>; Sat, 15 Sep 2001 08:06:29 -0400
Received: from [216.6.80.34] ([216.6.80.34]:5648 "EHLO
	dcmtechdom.dcmtech.co.in") by vger.kernel.org with ESMTP
	id <S272253AbRIOMG1>; Sat, 15 Sep 2001 08:06:27 -0400
Message-ID: <7FADCB99FC82D41199F9000629A85D1A01C65284@dcmtechdom.dcmtech.co.in>
From: Nitin Dhingra <nitin.dhingra@dcmtech.co.in>
To: "'Beihong Wu'" <beihong-l@raidzone.com>, linux-kernel@vger.kernel.org
Subject: RE: iSCSI support for Linux??
Date: Sat, 15 Sep 2001 17:38:24 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested Cisco's code
it has not implemented naming,
it is also faking the server side,
he is using swap file to simulate scsi disk.

no authentication also

any comments on this one let me know...



-----Original Message-----
From: Beihong Wu [mailto:beihong-l@raidzone.com]
Sent: Friday, September 14, 2001 7:20 AM
To: Nitin Dhingra
Subject: Re: iSCSI support for Linux??


Hi Nitin,

Very glad to know you have the iSCSI server side code with authentication. I
am eager to get it. So please email me with an attachment.

Thank you very much,

Beihong

----- Original Message -----
From: "Nitin Dhingra" <nitin.dhingra@dcmtech.co.in>
To: "'Beihong Wu'" <beihong-l@raidzone.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, September 14, 2001 12:54 AM
Subject: RE: iSCSI support for Linux??


> Hi Beihong,
> I don't remember either where I downloaded that one from.
> If you want I can mail you with an attachment.
>
> Regards,
> nitin
>
>
>  -----Original Message-----
> From: Beihong Wu [mailto:beihong-l@raidzone.com]
> Sent: Thursday, September 13, 2001 7:37 AM
> To: Nitin Dhingra; 'Ben Greear'
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: iSCSI support for Linux??
>
> Hi Nitin,
> I am also investigating the iSCSI stuff now, and focusing on the server
> side. I found most implementors have no support to authentication and
> security. That's the reason why I prefer to the Cisco one, which support
> CHAP authentication. But I can't find the server code in their site,
> http://sourceforge.net/projects/linux-iscsi/, only the driver and daemon
on
> client side here. So can you tell me where I can get a linux server code
> matching this client?
>
> Thank you very much,
>
> Beihong Wu
>
> ----- Original Message -----
> From: "Nitin Dhingra" <nitin.dhingra@dcmtech.co.in>
> To: "'Ben Greear'" <greearb@candelatech.com>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Thursday, September 06, 2001 3:02 AM
> Subject: RE: iSCSI support for Linux??
>
>
> > Hi Ben,
> > That is a pretty old iscsi draft that you have pointed to.
> > The latest iscsi draft ver 7 is available from ietf.org
> > I have about 5 different code's for iScsi
> >
> > 1) by Cisco :
> > I checked the code I guess this one is
> > working on both client and server Code
> >
> > 2) by Intel :
> > I checked the code faked on the server side
> > and was based on iscsi draft ver 3.
> >
> > 3) by UNH :
> > I checked the code faked on the server side
> > and was based on iscsi draft ver 3.
> >
> > 4) by Chris Loveland :
> > I checked the code faked on the server side
> > I don't remember right now where I got this one's code from
> >
> > 5) by Ashish A. Palekar :
> > I checked the code I guess this one is
> > working on both client and server Code
> > and was based on iscsi draft ver 3.
> > I don't remember where I got this one's code from
> >
> >
> > I guess cisco's code has also implemented authentication & security.
> > I think someone gave you the links and you must have d/l by now.
> > I guess by the end this year end there will be support for iScsi in
> > Linux Kernel.
> >
> > - Nitin
> >
> > -----Original Message-----
> > From: Ben Greear [mailto:greearb@candelatech.com]
> > Sent: Wednesday, September 05, 2001 11:13 AM
> > To: LKML
> > Subject: iSCSI support for Linux??
> >
> >
> > Does anyone know of any efforts to support iSCSI in Linux?
> >
> > Here's the ietf draft if anyone is curious:
> >
> > http://www.globecom.net/ietf/draft/draft-ietf-ips-iscsi-02.html
> >
> >
> > --
> > Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
> > President of Candela Technologies Inc      http://www.candelatech.com
> > ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
