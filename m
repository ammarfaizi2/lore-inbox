Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311272AbSCSOWG>; Tue, 19 Mar 2002 09:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311267AbSCSOVz>; Tue, 19 Mar 2002 09:21:55 -0500
Received: from mx1out.umbc.edu ([130.85.253.51]:48792 "EHLO mx1out.umbc.edu")
	by vger.kernel.org with ESMTP id <S311269AbSCSOVB>;
	Tue, 19 Mar 2002 09:21:01 -0500
Date: Tue, 19 Mar 2002 09:20:25 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: reading your email via tcpdump
In-Reply-To: <Pine.LNX.4.10.10203191009290.5694-100000@mikeg.wen-online.de>
Message-ID: <Pine.SGI.4.31L.02.0203190915250.7550126-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I lost track of attributions. Need more coffee,


> > 16:42:49.412862 10.0.0.101.netbios-dgm > 10.255.255.255.netbios-dgm:
> > >>> NBT UDP PACKET(138) Res=0x1102 ID=0x54 IP=10.0.0.101 Port=138 Length=193
> > Res2=0x0
> > SourceName=T1H6I3          NameType=0x00 (Workstation)
> > DestName=
> > SMB PACKET: SMBunknown (REQUEST)
> > SMB Command   =  0x43
> > Error class   =  0x46
> > Error code    =  20550
> > Flags1        =  0x45
> > Flags2        =  0x4E
> > Tree ID       =  17990
> > Proc ID       =  18000
> > UID           =  16720
> > MID           =  16707
> > Word Count    =  66
> > SMBError = ERROR: Unknown error (70,20550)

This looks like standard SMB garbage. It probably repeats on a regular
basis. From what I remember, I think it is a Windows box browsing
the network trying to discover other SMB boxes, finding a 'master
browser', and other such stuff.

I see it all the time when there are Windows machines about, and I'm
running tcpdump.

I imagine that someone who knows better, such as the Samba guys, would be
able to tell you exactly whats going on, and maybe some other interesting
tidbits of information.

(I hate SMB ... its really chatty ...)

--
-- John E. Jasen (jjasen1@umbc.edu)
-- User Error #2361: Please insert coffee and try again.

