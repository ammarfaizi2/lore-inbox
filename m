Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145190AbRA2FMZ>; Mon, 29 Jan 2001 00:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145192AbRA2FMF>; Mon, 29 Jan 2001 00:12:05 -0500
Received: from smtp-server.maine.rr.com ([204.210.65.66]:14997 "HELO
	smtp-server.maine.rr.com") by vger.kernel.org with SMTP
	id <S145190AbRA2FMB>; Mon, 29 Jan 2001 00:12:01 -0500
Message-ID: <001601c089b0$b1ec80d0$b001a8c0@caesar>
From: "paradox3" <paradox3@maine.rr.com>
To: "Michael Brown" <flight666@hotmail.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <F65Jqj0CYixMwInhdAH00002ef1@hotmail.com>
Subject: Re: Poor SCSI drive performance on SMP machine, 2.2.16
Date: Mon, 29 Jan 2001 00:02:35 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0013_01C08986.C8F05330"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0013_01C08986.C8F05330
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Here is the output from dmesg. How do I tell if it is improperly terminated?

Thanks, Para-dox (paradox3@maine.rr.com)




----- Original Message -----
From: "Michael Brown" <flight666@hotmail.com>
To: <paradox3@maine.rr.com>
Sent: Sunday, January 28, 2001 11:12 PM
Subject: Re: Poor SCSI drive performance on SMP machine, 2.2.16


> Your problem appears to be improper SCSI termination.
>
> You need to either
>   1) make sure your SCSI drive has termination enabled
> or
>   2) move your SCSI drive to the middle connector and put a terminator on
> the last connector
>
> Check your syslog and post to l-k the part where it detects your drives.
> I'll bet the adapter is throttling back quite dramatically in the presence
> of improper termination.
>
> --
> Michael Brown
>
> _________________________________________________________________
> Get your FREE download of MSN Explorer at http://explorer.msn.com
>
>

------=_NextPart_000_0013_01C08986.C8F05330
Content-Type: text/plain;
	name="dmesg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg.txt"

(scsi0) <Adaptec AIC-7890/1 Ultra2 SCSI host adapter> found at PCI 0/12/0=0A=
(scsi0) Wide Channel, SCSI ID=3D7, 32/255 SCBs=0A=
(scsi0) Downloading sequencer code... 392 instructions downloaded=0A=
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4=0A=
       <Adaptec AIC-7890/1 Ultra2 SCSI host adapter>=0A=
scsi : 1 host.=0A=
(scsi0:0:0:0) Synchronous at 40.0 Mbyte/sec, offset 15.=0A=
  Vendor: IBM       Model: DGHS09U           Rev: 0350=0A=
  Type:   Direct-Access                      ANSI SCSI revision: 03=0A=
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0=0A=
scsi : detected 1 SCSI disk total.=0A=
SCSI device sda: hdwr sector=3D 512 bytes. Sectors=3D 17916240 [8748 MB] =
[8.7 GB]=0A=
Partition check:=0A=
 sda: sda1 sda2 sda3=0A=

------=_NextPart_000_0013_01C08986.C8F05330--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
