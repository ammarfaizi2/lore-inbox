Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280026AbRJ3Qsz>; Tue, 30 Oct 2001 11:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280023AbRJ3Qsk>; Tue, 30 Oct 2001 11:48:40 -0500
Received: from aloha.egartech.com ([62.118.81.133]:49673 "HELO
	mx02.egartech.com") by vger.kernel.org with SMTP id <S280015AbRJ3QsO>;
	Tue, 30 Oct 2001 11:48:14 -0500
Message-ID: <3BDEDA78.5F2A7D19@egartech.com>
Date: Tue, 30 Oct 2001 19:51:04 +0300
From: Kirill Ratkin <kratkin@egartech.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lee Packham <linux@mswinxp.net>
CC: jo_ni@telia.com, linux-kernel@vger.kernel.org
Subject: Re: Still having problems with eepro100
In-Reply-To: <20011030123927.74e26501.jo_ni@telia.com> <14297.193.132.197.81.1004459024.squirrel@mail.mswinxp.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Oct 2001 16:48:43.0256 (UTC) FILETIME=[BC0A3780:01C16162]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've seen this problem when I compiled 2.4.10 kernel with gcc version
3.0.1. I think there is some problem with broadcast and multicast 
packets because I managed to make direct connection but I can't use
dhcpd or xdmcp.


Lee Packham wrote:
> 
> This problem is inherent in FreeBSD, OpenBSD, NetBSD as well as Linux. I
> spent a few months hacking my Sony Vaio with number of OS's (it has this
> network card built onto it).
> 
> The problem is fatal unfortunately and the only solution I found was
> Intel's e100 driver.
> 
> 'nuff said
> 
> Lee Packham
> 
> >
> > Hello,
> > Does anyone except me still having problems with the eepro100 drivers ?
> >
> > The network connection stalls and I'll get this message:
> >
> > eepro100: wait_for_cmd_done timeout!
> >
> > I am using the eepro100 drivers with my 100/10 card running in
> > 10mbit and it works in windows.
> >
> > I have been trying all new kernels + the ac patches but nothing
> >seems to work. The fun thing is that I only gets this problem
> > when I am running XFree, is this just a weird coincidence?
> >
> > /Johan Nilsson
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
