Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278472AbRJZNiJ>; Fri, 26 Oct 2001 09:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278479AbRJZNhu>; Fri, 26 Oct 2001 09:37:50 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3456 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S278472AbRJZNhh>; Fri, 26 Oct 2001 09:37:37 -0400
Date: Fri, 26 Oct 2001 09:38:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: M$ Does it again
Message-ID: <Pine.LNX.3.95.1011026093616.417A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am told that the latest Windows/XP has a Trojan built into it.
This was done as part of a deal with the United States Department
of Justice in settling the long term problem with Microsoft's
monopoly conviction.

This Trojan, upon specifc network inquiry, has the capability
of sending any intelligence that exists within the computer,
(Motherboard type, Peripherals, hard disk contents, the contents
of video buffers, etc.) to a remote network agent, any time the
machine is connected to a network.

Since the secret inquiry commands and port(s) must be known by
the developers, I hope that somebody is working on a Linux clone
that will pretend that it's a M$ machine owned by the Pope. 

Anyway, I have a XP machine here. I have monitored its startup
with a phony static IP address and NO default route that should
not be able to be routed out of the LAN. It does a lot of
network chatter and actually communicates with a name server
outside of our firewall!

I tried to find out how, so I first wanted to find some
M$ servers. This is what whois reports!!

[whois.internic.net]

Whois Server Version 1.3

Domain names in the .com, .net, and .org domains can now be registered
with many different competing registrars. Go to http://www.internic.net
for detailed information.

MICROSOFT.COM.ZZZ.SUCKS.AZZ.PHAEN.AS
MICROSOFT.COM.Z---HELLO-FROM-SIBERIA---I.Z3S.COM
MICROSOFT.COM.WILL.NEVER.SATISFY.A.TRUE.TELNETJUNKIE.COM
MICROSOFT.COM.WILL.NEVER.RUN.PUREDATA.NET
MICROSOFT.COM.WILL.LIVE.FOREVER.BUT.LUNIX.SUCKS-BYBIRTH.ARTISTICCHEESE.COM
MICROSOFT.COM.WILL.ALWAYS.FEARPENGUINS.COM
MICROSOFT.COM.WHOIS.RESULTS.MAKE.A.GREAT.HUMOUR-LIST.COM
MICROSOFT.COM.WAS.HACKED.TODAY.BY.JAMESSMALL.COM
MICROSOFT.COM.TONY.HAS.SEXUAL.IN.ADEQUACY.ORG
MICROSOFT.COM.TOLD.ME.TO.KILL.UR.PC.LIVE-EVIL.COM
MICROSOFT.COM.TOHA.KANKEI.ARIMASEN.300BPS.NET
MICROSOFT.COM.TAKES.IT.IN.THE.BUTT.FROM.WHILE1.ORG
MICROSOFT.COM.SUKZ.ORG
MICROSOFT.COM.SHOULD.GIVE.UP.BECAUSE.LINUXISGOD.COM
MICROSOFT.COM.SE.FAIT.HAX0RIZER.PAR.TOUT.LE.ZOY.ORG
MICROSOFT.COM.RUNSLINUX.NET
MICROSOFT.COM.PRODUCTS.WILL.NEVER.BE.SEEN.AT.MCNEIGHT.ORG
MICROSOFT.COM.OWNED.BY.MAT.HACKSWARE.COM
MICROSOFT.COM.NOTHING.HAPPENS.XYZZY.COM
MICROSOFT.COM.NAO.VALE.UM.CARALHO.NET
MICROSOFT.COM.N-AIME.BILL.QUE.QUAND.IL.N-EST.PAS.NU
MICROSOFT.COM.MUST.STOP.TAKEDRUGS.ORG
MICROSOFT.COM.MAKES.SHIT.ASS.SOFTWARE.T10.NET
MICROSOFT.COM.IS.THE.COMMERCIAL.ARM.OF.THE.WORLDGOV.ORG
MICROSOFT.COM.IS.SOON.GOING.TO.THE.DEATHCORPORATION.COM
MICROSOFT.COM.IS.SO.VERY.SKANKY.NET
MICROSOFT.COM.IS.SECRETLY.RUN.BY.ILLUMINATI.TERRORISTS.NET
MICROSOFT.COM.IS.NOTHING.COMPARED.TO.EVILGOAT.NET
MICROSOFT.COM.IS.NOTHING.BUT.A.MONSTER.ORG
MICROSOFT.COM.IS.NO.MATCH.FOR.THE.WANNABE.TERRORISTS.AT.JIMPHILLIPS.ORG
MICROSOFT.COM.IS.NO.MATCH.FOR.A.UNIXNINJA.COM
MICROSOFT.COM.IS.HOPELESSLY.INSECURE.ORG
MICROSOFT.COM.IS.GOD.BUT.LINUX.SUCKS-FOREVER.ARTISTICCHEESE.COM
MICROSOFT.COM.IS.AT.THE.MERCY.OF.DETRIMENT.ORG
MICROSOFT.COM.IS.A.STEAMING.HEAP.OF.FUCKING-BULLSHIT.NET
MICROSOFT.COM.HQ.SHOULD.HAVE.BEEN.MOVED.TO.BAGDAD.JUST.BEFORE.THE.GULFWAR.ORG
MICROSOFT.COM.HEBERGEUR.DE.SCHIZOPHRENE.ORG
MICROSOFT.COM.HAS.NO.LINUXCLUE.COM
MICROSOFT.COM.HACKED.BY.HACKSWARE.COM
MICROSOFT.COM.GUTS.NL
MICROSOFT.COM.FILLS.ME.WITH.BELLIGERENCE.NET
MICROSOFT.COM.FAIT.VRAIMENT.DES.LOGICIELS.A.TROIS.FRANCS.DOUZE.ORG
MICROSOFT.COM.DAN.HILLIER.OF.EXETER.UK.IS.A.DUMB.ASS.EVILJAM.COM
MICROSOFT.COM.CODERS.SHOULD.DUMP.WINDOWS.AND.CODE.FOR.THE.MORE.PRACTICALMAC.COM
MICROSOFT.COM.CANNOT.HACKUNIX.ORG
MICROSOFT.COM.AINT.WORTH.SHIT.KLUGE.ORG
MICROSOFT.COM.A.ETE.CREE.PAR.BILLOU.A.L.EPOQUE.OU.IL.FUMAIT.DU.COLA-COCA.ORG
MICROSOFT.COM.A.BIEN.BU.DU.COLA-COCA.SUR.L.ILE.DE.NUMEA.COM
MICROSOFT.COM

[Snipped]

Neat!

Anyway, XP will certainly find its way around a network. It discovers 
any Microsoft servers on the LAN and uses their default route. That's
how it finds the firewall. It then queries a bunch of servers using
port 53 (DNS) and does a zone-dump. Then it uses the mail port 25 to
exchange information. This information is not text. I don't know
what it is. 

It does this all upon startup! Our firewall doesn't 'know' about
this machine. It shouldn't even be able to talk outside because
our firewall interface does NAT and nobody has configured it for
the new machine.

If somebody has the time, it would be a good idea to look into
how they do this stuff and make some Linux software to emulate,
attack, expose, and thereby destroy the new Microsoft capability.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


