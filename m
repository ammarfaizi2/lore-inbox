Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbSKZNTR>; Tue, 26 Nov 2002 08:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265123AbSKZNTR>; Tue, 26 Nov 2002 08:19:17 -0500
Received: from mail.wincom.net ([209.216.129.3]:18707 "EHLO wincom.net")
	by vger.kernel.org with ESMTP id <S265095AbSKZNTQ>;
	Tue, 26 Nov 2002 08:19:16 -0500
From: "Dennis Grant" <trog@wincom.net>
Reply-to: trog@wincom.net
To: Tomas Szepe <szepe@pinerecords.com>, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel@vger.kernel.org
Date: Tue, 26 Nov 102 08:36:13 -0500
Subject: Re: Identifying/activating faster ATAxx modes (WAS kernel config tale of woe)
X-Mailer: CWMail Web to Mail Gateway 2.4e, http://netwinsite.com/top_mail.htm
Message-id: <3de379c5.5508.0@wincom.net>
X-User-Info: 24.57.34.150
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Dennis, could you possibly post the "hdparm -v" output too?

Your wish is my command:

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 3738/255/63, sectors = 60058656, start = 0

And while we're at it:

# /sbin/hdparm -d1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)


DG
