Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263766AbRFCXdb>; Sun, 3 Jun 2001 19:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263787AbRFCWQ0>; Sun, 3 Jun 2001 18:16:26 -0400
Received: from brauhaus.paderlinx.de ([194.122.103.4]:63945 "EHLO
	imail.paderlinx.de") by vger.kernel.org with ESMTP
	id <S263786AbRFCWQR>; Sun, 3 Jun 2001 18:16:17 -0400
Date: Mon, 4 Jun 2001 00:16:06 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: =?iso-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI-CD-Writer don't show up
Message-ID: <20010604001606.A8362@citd.de>
In-Reply-To: <Pine.LNX.4.20.0106020917560.13579-100000@citd.owl.de> <Pine.LNX.4.10.10106031820370.1735-100000@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.10.10106031820370.1735-100000@linux.local>; from groudier@club-internet.fr on Sun, Jun 03, 2001 at 06:38:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 03, 2001 at 06:38:27PM +0200, Gérard Roudier wrote:
> 
> On Sat, 2 Jun 2001, Matthias Schniedermeyer wrote:
>
> > I have 3 SCSI-CD-Writers. "Strange" is that the boot-process only finds
> > the first one (1 0 5 0), the other two i have to add with
> > 
> > echo "scsi add-single-device 2 0 4 0" > /proc/scsi/scsi
> > echo "scsi add-single-device 2 0 6 0" > /proc/scsi/scsi
> > 
> > to make them useable.
> > 
> > Here is the complete ist of my SCSI-Devices:
> > 
> > Host: scsi0 Channel: 00 Id: 06 Lun: 00
> >   Vendor: IBM      Model: DDYS-T18350N     Rev: S93E
> >   Type:   Direct-Access                    ANSI SCSI revision: 03
> > Host: scsi1 Channel: 00 Id: 00 Lun: 00
> >   Vendor: PLEXTOR  Model: CD-ROM PX-32TS   Rev: 1.03
> >   Type:   CD-ROM                           ANSI SCSI revision: 02
> > Host: scsi1 Channel: 00 Id: 01 Lun: 00
> >   Vendor: PIONEER  Model: DVD-ROM DVD-303  Rev: 1.10
> >   Type:   CD-ROM                           ANSI SCSI revision: 02
> > Host: scsi1 Channel: 00 Id: 05 Lun: 00
> >   Vendor: TEAC     Model: CD-R58S          Rev: 1.0N
> >   Type:   CD-ROM                           ANSI SCSI revision: 02
> > Host: scsi2 Channel: 00 Id: 02 Lun: 00
> >   Vendor: PIONEER  Model: DVD-ROM DVD-304  Rev: 1.03
> >   Type:   CD-ROM                           ANSI SCSI revision: 02
> > Host: scsi2 Channel: 00 Id: 03 Lun: 00
> >   Vendor: PIONEER  Model: DVD-ROM DVD-304  Rev: 1.03
> >   Type:   CD-ROM                           ANSI SCSI revision: 02
> > Host: scsi2 Channel: 00 Id: 04 Lun: 00
> >   Vendor: TEAC     Model: CD-R58S          Rev: 1.0K
> >   Type:   CD-ROM                           ANSI SCSI revision: 02
> > Host: scsi2 Channel: 00 Id: 06 Lun: 00
> >   Vendor: TEAC     Model: CD-R58S          Rev: 1.0P
> >   Type:   CD-ROM                           ANSI SCSI revision: 02
> > 
> > I have a "Symbios 53c1010 (Dual Channel Ultra 160)" and a "NCR 810a" The
> > two devices which are not found are connected through adapters onto the
> > second channel of the Symbios 53c1010.
> > 
> > Kernel is 2.4.4 or 2.4.5ac6. 
> > As host-adapter-driver i use the "SYM53C8XX"-driver
> > 
> > If other info is needed, no problem. :-)
> 
> You should check if your devices are enabled for SCAN in the NVRAM.

<Sound of head hitting the table>

I had disabled all IDs from scanning (except those which had a drive) when
i first installed the system.

Now i enabled all IDs for scanning. :-)




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

