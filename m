Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261329AbTC2W47>; Sat, 29 Mar 2003 17:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbTC2W47>; Sat, 29 Mar 2003 17:56:59 -0500
Received: from WARSL401PIP7.highway.telekom.at ([195.3.96.94]:584 "HELO
	email02.aon.at") by vger.kernel.org with SMTP id <S261329AbTC2W46>;
	Sat, 29 Mar 2003 17:56:58 -0500
From: Hermann Himmelbauer <dusty@violin.dyndns.org>
To: nbensa@yahoo.com, Norberto BENSA <nbensa@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Problem burning with ATAPI cd-rw
Date: Sun, 30 Mar 2003 00:07:58 +0100
User-Agent: KMail/1.5
References: <200303291907.38188.nbensa@gmx.net>
In-Reply-To: <200303291907.38188.nbensa@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303300007.58371.dusty@violin.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 March 2003 23:07, Norberto BENSA wrote:
> Hello all,
>
> I'm having a problem burning CDs. I ruined 3 cds (yeah, now I know '-dummy'
>
> :-/ and after checking dmesg, I see lots of these messages (or similar)
>
> 	ATAPI device hda:
> 	  Error: Illegal request -- (Sense key=0x05)
> 	  Invalid field in parameter list -- (asc=0x26, ascq=0x00)
> 	  The failed "Mode Select 10" packet command was:
> 	  "55 10 00 00 00 00 00 00 3c 00 00 00 "
> 	hda: packet command error: status=0x51 { DriveReady SeekComplete Error }
> 	hda: packet command error: error=0x50
> 	hda: packet command error: status=0x51 { DriveReady SeekComplete Error }
> 	hda: packet command error: error=0x50

Well - I don't know much about this, but I have some thoughts:

When do these errors occur while burning? At the start or somewhere in the 
middle?

I had LOTS of troubles writing CD's, but every time it was due to incompatible 
Media. So - did you besides changing the glibc also change your CD-Media?

Moreover I somehow wonder - don't you use the ide-scsi module? Which program 
are you using for writing your CDs?

My error messages looked different - first I got errors from the SCSI 
sub-system, second it told some "sense key" and "Media error". The errors 
were somehow more self explaining.

		Best Regards,
		Hermann

-- 
x1@aon.at
GPG key ID: 299893C7 (on keyservers)
FP: 0124 2584 8809 EF2A DBF9  4902 64B4 D16B 2998 93C7

