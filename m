Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266138AbUGEPJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266138AbUGEPJw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 11:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUGEPJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 11:09:52 -0400
Received: from www.logi-track.com ([213.239.193.212]:45712 "EHLO
	mail.logi-track.com") by vger.kernel.org with ESMTP id S266138AbUGEPIL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 11:08:11 -0400
Date: Mon, 5 Jul 2004 17:07:48 +0200
From: Markus Schaber <schabios@logi-track.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Block Device Caching
Message-Id: <20040705170748.0db8e193@kingfisher.intern.logi-track.com>
In-Reply-To: <1088772969.3643.11.camel@localhost.localdomain>
References: <20040630002014.4970b82d@kingfisher.intern.logi-track.com>
	<40E1FDEC.6020606@techsource.com>
	<40E279F4.4090708@hist.no>
	<20040630123828.7d48c6e6@kingfisher.intern.logi-track.com>
	<40E543D7.9030303@hist.no>
	<20040702140144.43088dc2@kingfisher.intern.logi-track.com>
	<1088772969.3643.11.camel@localhost.localdomain>
Organization: logi-track ag, =?ISO-8859-15?Q?z=FCrich?=
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: Nx5T&>Nj$VrVPv}sC3IL&)TqHHOKCz/|)R$i"*r@w0{*I6w;UNU_hdl1J4NI_m{IMztq=>cmM}1gCLbAF+9\#CGkG8}Y{x%SuQ>1#t:;Z(|\qdd[i]HStki~#w1$TPF}:0w-7"S\Ev|_a$K<GcL?@F\BY,ut6tC0P<$eV&ypzvlZ~R00!A
X-PGP-Key: http://schabi.de/pubkey.asc
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Fabian,

On Fri, 02 Jul 2004 14:56:09 +0200
FabF <fabian.frederick@skynet.be> wrote:

> > [Caching problems]
> Did you played with hdparm -m <device> ?

I'm afraid this does not work as this are not IDE disks:

bear:~# hdparm -m /dev/daten/testing
/dev/daten/testing not supported by hdparm
bear:~# hdparm -m /dev/cciss/c0d0p2

/dev/cciss/c0d0p2:
 operation not supported on SCSI disks


Greets,
Markus

-- 
markus schaber | dipl. informatiker
logi-track ag | rennweg 14-16 | ch 8001 zürich
phone +41-43-888 62 52 | fax +41-43-888 62 53
mailto:schabios@logi-track.com | www.logi-track.com
