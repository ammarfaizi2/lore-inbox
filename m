Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTKNIoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 03:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTKNIoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 03:44:20 -0500
Received: from port-213-148-149-130.reverse.qsc.de ([213.148.149.130]:19978
	"EHLO eumucln02.muc.eu.mscsoftware.com") by vger.kernel.org with ESMTP
	id S262192AbTKNIoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 03:44:18 -0500
In-Reply-To: <shsislof1n4.fsf@charged.uio.no>
Subject: Re: nfs_statfs: statfs error = 116
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Jesse Pollard <jesse@cats-chateau.net>,
       Linux kernel <linux-kernel@vger.kernel.org>, root@chaos.analogic.com
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFC480E5CC.3BE734ED-ONC1256DDE.002F74B5-C1256DDE.002FF160@mscsoftware.com>
From: Martin.Knoblauch@mscsoftware.com
Date: Fri, 14 Nov 2003 09:43:39 +0100
X-MIMETrack: Serialize by Router on EUMUCLN02/MSCsoftware(Release 6.0.2CF1|June 9, 2003) at
 11/14/2003 09:45:04 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






Trond Myklebust <trond.myklebust@fys.uio.no> wrote on 11/13/2003 09:34:55
PM:

> >>>>> " " == Jesse Pollard <jesse@cats-chateau.net> writes:
>
>      > ESTALE should occur whenever the client looses connection to
>      > the server, or thinks it has lost connection.
>
> No it should not.
>
> Cheers,
>   Trond
Hi Trond,

 just by incident I found one reason when an user space application can get
the ESTALE in our setup (Linux client RH-2.4.20-18.7smp, Solaris 2.8
Server). I accidentally run iozone on two clients with the output file
being the same and residing on the NFS Server. Pure luser error, but it
produced ESTALE pretty much reproducibly.

B^HCheers
Martin
--
Martin Knoblauch
Senior System Architect
MSC.software GmbH
Am Moosfeld 13
D-81829 Muenchen, Germany

e-mail: martin.knoblauch@mscsoftware.com
http://www.mscsoftware.com
Phone/Fax: +49-89-431987-189 / -7189
Mobile: +49-174-3069245


