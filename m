Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292539AbSCSUR3>; Tue, 19 Mar 2002 15:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292555AbSCSURS>; Tue, 19 Mar 2002 15:17:18 -0500
Received: from chaos.analogic.com ([204.178.40.224]:40833 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292539AbSCSURA>; Tue, 19 Mar 2002 15:17:00 -0500
Date: Tue, 19 Mar 2002 15:19:55 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andreas Dilger <adilger@clusterfs.com>
cc: John Jasen <jjasen1@umbc.edu>, Mike Galbraith <mikeg@wen-online.de>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: reading your email via tcpdump
In-Reply-To: <20020319154734.GM470@turbolinux.com>
Message-ID: <Pine.LNX.3.95.1020319151601.4151A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, Andreas Dilger wrote:

> On Mar 19, 2002  10:11 -0800, Mike Fedyk wrote:
> > That's not the problem part of the tcpdump output.  The problem is that part
> > of an email previously read on the linux box (with no samba runing. (also,
> > no smbfs MikeG?)) showed up in the tcpdump output...
> 

The data sent/received on the network is precious. You will not have
any 'extra' data on its end except for possibly a single byte if the
data didn't have an even length. Note that these things are checksummed
and also CRCed in the hardware.

If you got part of somebody's email, I think you should look at
the `tcpdump` source. It may be the culprit...

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

