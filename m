Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277072AbRJQTQG>; Wed, 17 Oct 2001 15:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277071AbRJQTP5>; Wed, 17 Oct 2001 15:15:57 -0400
Received: from atlrel1.hp.com ([156.153.255.210]:55544 "HELO atlrel1.hp.com")
	by vger.kernel.org with SMTP id <S277072AbRJQTPm>;
	Wed, 17 Oct 2001 15:15:42 -0400
Message-ID: <C5C45572D968D411A1B500D0B74FF4A80418D573@xfc01.fc.hp.com>
From: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
To: "'David S. Miller'" <davem@redhat.com>,
        "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org,
        "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
Subject: RE: Problem with 2.4.14prex and qlogicfc
Date: Wed, 17 Oct 2001 15:16:03 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So now please try the broken 2.4.13-preX kernels with
> CONFIG_SCSI_QLOGIC_FC_FIRMWARE set, does that
> make any difference?
> 
> I have a feeling that will make it work.
> 
> Franks a lot,
> David S. Miller
> davem@redhat.com
>

I've done that and the problem is still there.  It no longer gives me the
perpetual link is up message when trying to mount storage on the fibre
channel disks.  Now it just stops.  I booted without any of the fibre
storage being mounted and ran an fdisk on the storage in question.  The
response from the ps -eo cmd,wchan is:
fdisk /dev/sdc lock_page

Hope this helps,
Cary
