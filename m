Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132295AbRDALJ3>; Sun, 1 Apr 2001 07:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132324AbRDALJT>; Sun, 1 Apr 2001 07:09:19 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:62983 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132295AbRDALJJ>; Sun, 1 Apr 2001 07:09:09 -0400
X-Apparently-From: <nietzel@yahoo.com>
Message-ID: <000901c0bae7$ab340a20$1401a8c0@nietzel>
Reply-To: "Earle Nietzel" <nietzel@yahoo.com>
From: "Earle Nietzel" <nietzel@yahoo.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200103312307.f2VN73s55018@aslan.scsiguy.com>
Subject: Re: Minor 2.4.3 Adaptec Driver Problems 
Date: Sun, 1 Apr 2001 13:09:30 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Umm.  This isn't an aic7xxx driver problem at all.  The SCSI layer
> determines the order of bus attachment *amongst* the various
> SCSI HBA (or SCSI HBA like) drivers in the system.  In this case,
> it has decided to probe your IDE devices as SCSI devices first.
> Why it does this I don't really know (link order perhaps???).  One
> way around this would be to put your IDE driver into an initial
> ram disk and compile the aic7xxx driver directly into the kernel.

My IDE and AIC7xxx drivers are compiled in to the kernel. I normally conpile
system dependent drivers into the kernel and leave the rest modules when
possible.

> This should force the system to assign the devices the other way
> around.

In all prior versions of the kernel 2.4.3 I have never had this problem. I
have both 2.4.2 & 2.4.3 and when booting from one to the other 2.4.2 orders
my SCSI id's correctly and 2.4.3 doesn't.

It really wouldn't make a big deal but I consider my cdroms and zip drives
to be removable devices and if I ever decided to remove my zip my scsi ids
will change. Removing a harddrive is not the same as removing a zip!

Are there other people with the same problem?

Earle

If you need any more info don't hesitate to ask.


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

