Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129117AbRAaWBg>; Wed, 31 Jan 2001 17:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbRAaWBR>; Wed, 31 Jan 2001 17:01:17 -0500
Received: from esteel10.client.dti.net ([209.73.14.10]:26433 "EHLO
	nynews01.e-steel.com") by vger.kernel.org with ESMTP
	id <S129076AbRAaWBC>; Wed, 31 Jan 2001 17:01:02 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
Newsgroups: e-steel.mailing-lists.linux.linux-kernel
Subject: Re: problems with sblive as well as 3com 3c905
Date: 31 Jan 2001 17:00:54 -0500
Organization: e-STEEL Netops news server
Message-ID: <m3lmrrjsa1.fsf@shookay.e-steel.com>
In-Reply-To: <3A787D97.CBF7B327@supremedesigns.com> <003701c08bcc$19b8bae0$7930000a@hcd.net>
NNTP-Posting-Host: shookay.e-steel
X-Trace: nynews01.e-steel.com 980978358 7335 192.168.3.43 (31 Jan 2001 21:59:18 GMT)
X-Complaints-To: news@nynews01.e-steel.com
NNTP-Posting-Date: 31 Jan 2001 21:59:18 GMT
X-Newsreader: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You need to get the latest modutils: the directory tree under /lib/modules
changed recently and that's why it works if you create symlinks...

whtdrgn@mail.cannet.com ("Timothy A. DeWees") writes:

> You need to create a symlink
> 
> ln -s /lib/modules/2.4.1/kernel/drivers/net /lib/modules/2.4.1/net
> 
> That will fix the nic, I am not sure about sound.  You may need to
> create a misc link like
> 
> ln -s /lib/modules/2.4.1/kernel/drivers/misc /lib/modules/2.4.1/misc
> 
> 
> ----- Original Message -----
> From: "Lukasz Gogolewski" <lucas@supremedesigns.com>
> To: <linux-kernel@vger.kernel.org>
> Sent: Wednesday, January 31, 2001 4:03 PM
> Subject: problems with sblive as well as 3com 3c905
> 
> 
> > After I compiled kernel 2.4.1 on rh 6.2 I enabled module support for 2
> > of those devices.
> >
> > However when I rebooted my machine both of those devices are not
> > working.
> >
> > I don't know what's wrong since I did make moudle and make
> > module_install.
> >
> > When I try to configure mdoule for the sound card, I get a message
> > saying that module wasn't found.
> >
> > For the network card I get Delaying initialization
> >
> > any suggestions on how to fix it?
> >
> > - Lucas
> >
> >
> >
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-- 
Mathieu CHOUQUET-STRINGER              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
