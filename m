Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290120AbSCSSjp>; Tue, 19 Mar 2002 13:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290184AbSCSSj0>; Tue, 19 Mar 2002 13:39:26 -0500
Received: from www.wen-online.de ([212.223.88.39]:43538 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S290120AbSCSSjP>;
	Tue, 19 Mar 2002 13:39:15 -0500
Date: Tue, 19 Mar 2002 19:56:27 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: John Jasen <jjasen1@umbc.edu>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: reading your email via tcpdump
In-Reply-To: <20020319181130.GQ2254@matchmail.com>
Message-ID: <Pine.LNX.4.10.10203191953420.421-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, Mike Fedyk wrote:

> On Tue, Mar 19, 2002 at 09:20:25AM -0500, John Jasen wrote:
> > > > 16:42:49.412862 10.0.0.101.netbios-dgm > 10.255.255.255.netbios-dgm:
> > > > >>> NBT UDP PACKET(138) Res=0x1102 ID=0x54 IP=10.0.0.101 Port=138 Length=193
> > > > Res2=0x0
> > > > SourceName=T1H6I3          NameType=0x00 (Workstation)
> > > > DestName=
> > > > SMB PACKET: SMBunknown (REQUEST)
> > > > SMB Command   =  0x43
> > > > Error class   =  0x46
> > > > Error code    =  20550
> > > > Flags1        =  0x45
> > > > Flags2        =  0x4E
> > > > Tree ID       =  17990
> > > > Proc ID       =  18000
> > > > UID           =  16720
> > > > MID           =  16707
> > > > Word Count    =  66
> > > > SMBError = ERROR: Unknown error (70,20550)
> > 
> > This looks like standard SMB garbage. It probably repeats on a regular
> > basis. From what I remember, I think it is a Windows box browsing
> > the network trying to discover other SMB boxes, finding a 'master
> > browser', and other such stuff.
> > 
> > I see it all the time when there are Windows machines about, and I'm
> > running tcpdump.
> > 
> > I imagine that someone who knows better, such as the Samba guys, would be
> > able to tell you exactly whats going on, and maybe some other interesting
> > tidbits of information.
> > 
> > (I hate SMB ... its really chatty ...)
> 
> That's not the problem part of the tcpdump output.  The problem is that part
> of an email previously read on the linux box (with no samba runing. (also,
> no smbfs MikeG?)) showed up in the tcpdump output...

Yes.  That's exactly what worried me. (no clue as to security issues)

	-Mike

