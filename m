Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269907AbRHEDGo>; Sat, 4 Aug 2001 23:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269908AbRHEDGZ>; Sat, 4 Aug 2001 23:06:25 -0400
Received: from titan.golden.net ([199.166.210.90]:46837 "EHLO titan.golden.net")
	by vger.kernel.org with ESMTP id <S269907AbRHEDGW>;
	Sat, 4 Aug 2001 23:06:22 -0400
From: "John L. Males" <software_iq@TheOffice.net>
Organization: Toronto, Ontario, Canada
To: Keith Owens <kaos@ocs.com.au>
Date: Sat, 4 Aug 2001 23:06:20 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re[03]: Linux Kernel 2.4.8-pre2 Compile Attempts
Reply-to: software_iq@TheOffice.net
CC: linux-kernel@vger.kernel.org
Message-ID: <3B6C7FEC.14087.6EC6D3@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Keith,

I just wanted to thank you for taking the time to make your reply.  I
am sorry I forgot to mention I am not on the mailing list.  I just
discovered your reply a few minutes ago.

I had prior to sending the original message searched on the internet
for what I "needed" to know to proceed in my attempts.  I am said to
say at that time nothing in the many, and I did read many of the
results litterally, about the programs I needed to update to that
make be part of issue.

Two days ago I did more and more searching and happened along some
links, text files, and in fact the very file you referred to in your
reply online.  I then proceeded to get the SuSE varients I needed. 
Suffice to say the SuSE source RPMs had their share of problems in
being compiled.  In end after my tinkering of the SuSE source RPMs I
managed to start up a 2.4.7 SuSE varient.  I have not gone back to
trying to compile the pre-patch kernel source I had problems with
originally.  The reason is simple, the memory observations I was
keenly interested in indicated some possible issues.

I have since send to the Kernel Mailing list my initial observations
and a request on how I may be able to get the metric information on
Kernel/Application memory use.  That of course is a different issue
and discussion from the eMail you were so kind to make a reply.

Again I want to thank you or the time you took to reply and pointing
me to where I should look for the solution.  I do tend to read
documentation much more than most, but sometimes I miss something or
look in wrong place.  In this case I looked in wrong places combined
with me still learning some of the "finer" points of such Linux
activities as compiling the Kernel.  I at least now in event I forget
to mention in future that I am not on the Kernel mailing list the
mailing list archives are timely in their updates.

Keith I really appreciate your feedback and time to answer.  I cannot
express this enough given my failure to indicate I was not on the
mailing list, nor aware how frequent the list archive may be updated
so I can find out if any replies were made to the list.


Regards,

John L. Males
Software I.Q. Consulting
Toronto, Ontario
Canada
04 August 2001 23:06
mailto:software_iq@TheOffice.net
mailto:jlmales@softhome.net


======================================================
======================================================
Re: Linux Kernel 2.4.8-pre2 Compile
Attempts

From: Keith Owens (kaos@ocs.com.au)
Date: Tue Jul 31 2001 - 04:29:09 EST 

     Next message: DH: "(no subject)" 
     Previous message: Martin Knoblauch: "Re: eepro100 2.4.7-ac3
problems (apm related)" 
     In reply to: John L. Males: "Linux Kernel 2.4.8-pre2 Compile
Attempts" 
     Messages sorted by: [ date ] [ thread ] [ subject ] [ author ] 



On Tue, 31 Jul 2001 02:31:25 -0500, 
"John L. Males" <software_iq@TheOffice.net> wrote: 
>Without giving the gory details, I am curious to know if there are 
>still problems compiling the 2.4.8-pre2 kernel (2.4.7 + 2.4.8-pre2 
>patch).... Also what is installed in /lib/modules 
>tree is not just modules, but some extensive set of the kernel
>source  tree with object code mixed in for adventure of finding. 
> 
>Am I completely out to lunch 
>here, or should I just hang in. I am doing ok with the 2.2.19 

You are out to lunch, or rather your programs are. Upgrade all your 
utilities to the values listed in Documentation/Changes. 

- - 
To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in 
the body of a message to majordomo@vger.kernel.org 
More majordomo info at http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at http://www.tux.org/lkml/ 



     Next message: DH: "(no subject)" 
     Previous message: Martin Knoblauch: "Re: eepro100 2.4.7-ac3
problems (apm related)" 
     In reply to: John L. Males: "Linux Kernel 2.4.8-pre2 Compile
Attempts" 
     Messages sorted by: [ date ] [ thread ] [ subject ] [ author ] 



This archive was generated by hypermail 2b29 : Tue Jul 31 2001 -
21:00:50 EST 
======================================================
======================================================
Linux Kernel 2.4.8-pre2 Compile Attempts

From: John L. Males (software_iq@TheOffice.net)
Date: Tue Jul 31 2001 - 02:31:25 EST 

     Next message: Subhash S: "Question about gettimeofday" 
     Previous message: David Ford: "Re: laptops and journalling
filesystems" 
     Next in thread: Keith Owens: "Re: Linux Kernel 2.4.8-pre2
Compile Attempts" 
     Reply: Keith Owens: "Re: Linux Kernel 2.4.8-pre2 Compile
Attempts" 
     Messages sorted by: [ date ] [ thread ] [ subject ] [ author ] 



- -----BEGIN PGP SIGNED MESSAGE----- 
Hash: SHA1 

Hello, 

Without giving the gory details, I am curious to know if there are 
still problems compiling the 2.4.8-pre2 kernel (2.4.7 + 2.4.8-pre2 
patch). Specifically the "make modules" does not complete dues to 
some errors, the kernel compiles, but will not start after it is 
decompressed, if one uses the "-k -i" options of make for the modules
to skip those that are really not a big concern to me anyway, there 
seems to be problems with "make modules_install" either not working 
or some other strange thing. Also what is installed in /lib/modules 
tree is not just modules, but some extensive set of the kernel source
tree with object code mixed in for adventure of finding. 

All I really wanted to do was give the 2.4.8pre2 kernel a try to see 
if memory management was improved with the recent approaches. I did 
try a prior 2.4 kernel, not sure, but think it was 2.4.4 and it had 
its share of compile problems via make. Am I completely out to lunch 
here, or should I just hang in. I am doing ok with the 2.2.19 Linus 
Kernel with the Openwall patch, but I really would like to observe 
the work in memory management of the kernel to determine if may 
observations on how memory is management in the bigger picture to 
determine if I wish to offer my observations to the memory management
discussion. 

Regards, 

John L. Males 
Software I.Q. Consulting 
Toronto, Ontario 
Canada 
31 July 2001 02:31 
mailto:software_iq@TheOffice.net 
mailto:jlmales@softhome.net 

- -----BEGIN PGP SIGNATURE----- 
Version: PGPfreeware 6.5.8 for non-commercial use
<http://www.pgp.com> 

iQA/AwUBO2ZeyfLzhJbmoDZ+EQLWMQCeJCO8ncZ8WW51ufl+CWt2oLhDsmoAnj4U 
XmokefDd3smnPvFBdoO9wdDd 
=XX0U 
- -----END PGP SIGNATURE----- 

- - 
To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in 
the body of a message to majordomo@vger.kernel.org 
More majordomo info at http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at http://www.tux.org/lkml/ 



     Next message: Subhash S: "Question about gettimeofday" 
     Previous message: David Ford: "Re: laptops and journalling
filesystems" 
     Next in thread: Keith Owens: "Re: Linux Kernel 2.4.8-pre2
Compile Attempts" 
     Reply: Keith Owens: "Re: Linux Kernel 2.4.8-pre2 Compile
Attempts" 
     Messages sorted by: [ date ] [ thread ] [ subject ] [ author ] 



This archive was generated by hypermail 2b29 : Tue Jul 31 2001 -
21:00:49 EST 
======================================================
======================================================

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use <http://www.pgp.com>

iQA/AwUBO2zGNvLzhJbmoDZ+EQKvJgCg4FzcCr27OpVPF86eDGGTHeY2ydAAoKkn
ryghyVumGdLXvI5elJ3PXszR
=N83o
-----END PGP SIGNATURE-----

