Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRBZWGr>; Mon, 26 Feb 2001 17:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129167AbRBZWGh>; Mon, 26 Feb 2001 17:06:37 -0500
Received: from ns1.whiterose.net ([208.155.122.237]:59666 "HELO
	ns1.whiterose.net") by vger.kernel.org with SMTP id <S129166AbRBZWGe>;
	Mon, 26 Feb 2001 17:06:34 -0500
Date: Mon, 26 Feb 2001 17:02:25 -0500 (EST)
From: M Sweger <mikesw@ns1.whiterose.net>
To: linux-kernel@vger.kernel.org, dledford@redhat.com
Subject: linux 2.2.19pre14 SCSI v5.1.33 patch AIC7895 comments.
Message-ID: <Pine.BSF.4.21.0102261658420.37289-100000@ns1.whiterose.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Doug,

    Just to let you know that I've upgraded from linux 2.2.19pre5
to linux 2.2.19pre14 and here is an updated status.

1). My machine is a Dell optiplex 333mhz Intel with a 2940U2W AIC-7895
    chipset and SCSI BIOS v1.33S2   (where S means special Dell stuff)


2). This newer patch includes the new scsi driver
    v5.1.33/3.2.4 instead of the old one v5.1.31/3.2.4.

3). Earlier, I emailed you about a,
     "Data overrun in data-in phase, tag 1;
      Have seen  Data Phase. Length=255, NumSGs=1.
      sg[0] - Addr = 0x7fea380 : Length 255"
   
error message during bootup for linux kernels 2.2.15-2.2.19pre5.

4). HOWEVER, with this newer patch, the "data overrun" error messages
    disappear. I've recompiled with TCQ enabled and disabled and with
    the TCQ queue size 8 and 24 and no boot problem was encountered.
    Moreover, there wasn't any problems running it on UMSDOS with
    a Western Digital 9.1 Gig SCSI drive.

    I wonder what changed that eliminated this data overrun problem
    in this newer SCSI driver v5.1.33? The Changelog doesn't seem
    to hint at a fix in this area.


Things look good to go.

 

