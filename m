Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129441AbRAXS5k>; Wed, 24 Jan 2001 13:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbRAXS5b>; Wed, 24 Jan 2001 13:57:31 -0500
Received: from oscargrouch.ny.genx.net ([206.64.4.76]:10002 "HELO
	oscargrouch.hq.ny.genx.net") by vger.kernel.org with SMTP
	id <S129441AbRAXS5T>; Wed, 24 Jan 2001 13:57:19 -0500
Message-ID: <BF0800DEA68DD4118B2D00B0D049C021014B2442@element.ny.genx.net>
From: "Margulies, Adam" <amarguli@hotjobs.com>
To: "'Heitzso'" <xxh1@cdc.gov>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: fyi megaraid problems
Date: Wed, 24 Jan 2001 13:51:19 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C08636.A39C40BA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C08636.A39C40BA
Content-Type: text/plain;
	charset="iso-8859-1"

I've compiled the 2.2.18 and 2.4.0 kernels with the latest megaraid driver
(1.14b)
and they work well. You should also upgrade your firmware to L148 (bios
3.11).
I think the firmware revision depends on which model card you have, I have
the
1600 Elite.

This is on a Penguin Relion 120, 2 CPUs, PIII, 1G RAM.
Two 35G drives configured as one logical drive.

I will say that I did float around for a while and found quite a few
different
versions of the driver (1.07b,1.13s,1b08b,1.13s0,1.14b, I have them all!)
before Venkatesh Ramamurthy at AMI helped me figure this all out. (thanks
Venkatesh!)

Venkatesh posted the 1.14b driver to this list a week or two ago, and you
can
get the firmware upgrade from ami.com.




-----Original Message-----
From: Heitzso [mailto:xxh1@cdc.gov]
Sent: Wednesday, January 24, 2001 11:51 AM
To: 'linux-kernel@vger.kernel.org'
Subject: fyi megaraid problems


don't know if this has been covered/studied

datapoints I've run across re the megaraid
(scsi raid driver, american megatrends)

box: Dell PowerEdge 2300, 2 cpus, 1G RAM

hard drive setup as single drive via raid
controller

RH6.1, compiled 2.2.13, megaraid works!

RH7.0 install/upgrade breaks on megaraid
then, after forcing RH7.0 upgrade by hand 
 (completely snuffed up with all updates as of jan 23 am ...)
RH7.0 kernel (out of the rpm box 686 smp) breaks on megaraid
RH7.0 2.2.16 kernel source from rpm 
 compiled using 2.2.13 .config file
 and make oldconfig generates kernel that
 breaks on megaraid (used RH provided
 scripts to compile with kgcc)
2.2.18 kernel (kernel.org) compiled with gcc on RH7.0
 breaks on megaraid during boot

BUT! 2.4.1pre10 (kernel.org), compiled with gcc on RH7.0
 the megaraid driver works again!

I was surprised that even 2.2.18 breaks
then 2.4.1pre10 works, given RH's alliance
with Dell.

I compiled a 2.4.0 and set it up in
lilo.conf but haven't tried booting to it.

If it's useful to anyone, now that I have
a good booting kernel I could recompile the
old 2.2.13 setup and see whether the problem
is due to a bad compiler env in RH7.0 or
due to a bad megaraid module (i.e. if kernel
that works fine now compiled under 6.1 
breaks when recompiled under 7.0 then bug
is in the RH7.0 compiler env; else bug is
in megaraid shipped with 2.2.16, 2.2.18)

Let me know if someone needs a datapoint.

Heitzso
xxh1@cdc.gov
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

------_=_NextPart_001_01C08636.A39C40BA
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<META NAME="Generator" CONTENT="MS Exchange Server version 5.5.2650.12">
<TITLE>RE: fyi megaraid problems</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=2>I've compiled the 2.2.18 and 2.4.0 kernels with the latest megaraid driver (1.14b)</FONT>
<BR><FONT SIZE=2>and they work well. You should also upgrade your firmware to L148 (bios 3.11).</FONT>
<BR><FONT SIZE=2>I think the firmware revision depends on which model card you have, I have the</FONT>
<BR><FONT SIZE=2>1600 Elite.</FONT>
</P>

<P><FONT SIZE=2>This is on a Penguin Relion 120, 2 CPUs, PIII, 1G RAM.</FONT>
<BR><FONT SIZE=2>Two 35G drives configured as one logical drive.</FONT>
</P>

<P><FONT SIZE=2>I will say that I did float around for a while and found quite a few different</FONT>
<BR><FONT SIZE=2>versions of the driver (1.07b,1.13s,1b08b,1.13s0,1.14b, I have them all!)</FONT>
<BR><FONT SIZE=2>before Venkatesh Ramamurthy at AMI helped me figure this all out. (thanks Venkatesh!)</FONT>
</P>

<P><FONT SIZE=2>Venkatesh posted the 1.14b driver to this list a week or two ago, and you can</FONT>
<BR><FONT SIZE=2>get the firmware upgrade from ami.com.</FONT>
</P>
<BR>
<BR>
<BR>

<P><FONT SIZE=2>-----Original Message-----</FONT>
<BR><FONT SIZE=2>From: Heitzso [<A HREF="mailto:xxh1@cdc.gov">mailto:xxh1@cdc.gov</A>]</FONT>
<BR><FONT SIZE=2>Sent: Wednesday, January 24, 2001 11:51 AM</FONT>
<BR><FONT SIZE=2>To: 'linux-kernel@vger.kernel.org'</FONT>
<BR><FONT SIZE=2>Subject: fyi megaraid problems</FONT>
</P>
<BR>

<P><FONT SIZE=2>don't know if this has been covered/studied</FONT>
</P>

<P><FONT SIZE=2>datapoints I've run across re the megaraid</FONT>
<BR><FONT SIZE=2>(scsi raid driver, american megatrends)</FONT>
</P>

<P><FONT SIZE=2>box: Dell PowerEdge 2300, 2 cpus, 1G RAM</FONT>
</P>

<P><FONT SIZE=2>hard drive setup as single drive via raid</FONT>
<BR><FONT SIZE=2>controller</FONT>
</P>

<P><FONT SIZE=2>RH6.1, compiled 2.2.13, megaraid works!</FONT>
</P>

<P><FONT SIZE=2>RH7.0 install/upgrade breaks on megaraid</FONT>
<BR><FONT SIZE=2>then, after forcing RH7.0 upgrade by hand </FONT>
<BR><FONT SIZE=2>&nbsp;(completely snuffed up with all updates as of jan 23 am ...)</FONT>
<BR><FONT SIZE=2>RH7.0 kernel (out of the rpm box 686 smp) breaks on megaraid</FONT>
<BR><FONT SIZE=2>RH7.0 2.2.16 kernel source from rpm </FONT>
<BR><FONT SIZE=2>&nbsp;compiled using 2.2.13 .config file</FONT>
<BR><FONT SIZE=2>&nbsp;and make oldconfig generates kernel that</FONT>
<BR><FONT SIZE=2>&nbsp;breaks on megaraid (used RH provided</FONT>
<BR><FONT SIZE=2>&nbsp;scripts to compile with kgcc)</FONT>
<BR><FONT SIZE=2>2.2.18 kernel (kernel.org) compiled with gcc on RH7.0</FONT>
<BR><FONT SIZE=2>&nbsp;breaks on megaraid during boot</FONT>
</P>

<P><FONT SIZE=2>BUT! 2.4.1pre10 (kernel.org), compiled with gcc on RH7.0</FONT>
<BR><FONT SIZE=2>&nbsp;the megaraid driver works again!</FONT>
</P>

<P><FONT SIZE=2>I was surprised that even 2.2.18 breaks</FONT>
<BR><FONT SIZE=2>then 2.4.1pre10 works, given RH's alliance</FONT>
<BR><FONT SIZE=2>with Dell.</FONT>
</P>

<P><FONT SIZE=2>I compiled a 2.4.0 and set it up in</FONT>
<BR><FONT SIZE=2>lilo.conf but haven't tried booting to it.</FONT>
</P>

<P><FONT SIZE=2>If it's useful to anyone, now that I have</FONT>
<BR><FONT SIZE=2>a good booting kernel I could recompile the</FONT>
<BR><FONT SIZE=2>old 2.2.13 setup and see whether the problem</FONT>
<BR><FONT SIZE=2>is due to a bad compiler env in RH7.0 or</FONT>
<BR><FONT SIZE=2>due to a bad megaraid module (i.e. if kernel</FONT>
<BR><FONT SIZE=2>that works fine now compiled under 6.1 </FONT>
<BR><FONT SIZE=2>breaks when recompiled under 7.0 then bug</FONT>
<BR><FONT SIZE=2>is in the RH7.0 compiler env; else bug is</FONT>
<BR><FONT SIZE=2>in megaraid shipped with 2.2.16, 2.2.18)</FONT>
</P>

<P><FONT SIZE=2>Let me know if someone needs a datapoint.</FONT>
</P>

<P><FONT SIZE=2>Heitzso</FONT>
<BR><FONT SIZE=2>xxh1@cdc.gov</FONT>
<BR><FONT SIZE=2>-</FONT>
<BR><FONT SIZE=2>To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel&quot; in</FONT>
<BR><FONT SIZE=2>the body of a message to majordomo@vger.kernel.org</FONT>
<BR><FONT SIZE=2>Please read the FAQ at <A HREF="http://www.tux.org/lkml/" TARGET="_blank">http://www.tux.org/lkml/</A></FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C08636.A39C40BA--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
