Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbTANWHW>; Tue, 14 Jan 2003 17:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbTANWHV>; Tue, 14 Jan 2003 17:07:21 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:56009 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S265385AbTANWHT>; Tue, 14 Jan 2003 17:07:19 -0500
Message-Id: <5.1.0.14.2.20030114141302.0d5e55e8@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 14 Jan 2003 14:15:56 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: [BK] Bluetooth updates for 2.4.21-pre4 
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Please pull from
        bk://linux-bt.bkbits.net/bt-2.4

This will update the following files:

 net/bluetooth/hci_sock.c |    2 +-
 net/bluetooth/sco.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

through these ChangeSets:

<marcel@holtmann.org> (02/12/17 1.803.2.2)
   [Bluetooth] Replace info message about SCO MTU with BT_DBG
   
   This patch replaces one BT_INFO with BT_DBG. With this change the
   use of getsockopt() don't pollute the kernel log with the info about
   the SCO MTU if debugging is disabled.

<marcel@holtmann.org> (02/12/17 1.803.2.1)
   [Bluetooth] Make READ_VOICE_SETTING available for normal users
   
   This makes the HCI command READ_VOICE_SETTING available for normal
   users.

Thanks


Max

http://bluez.sf.net
http://vtun.sf.net

