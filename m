Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268218AbTBYUtC>; Tue, 25 Feb 2003 15:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268290AbTBYUtC>; Tue, 25 Feb 2003 15:49:02 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:16346 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S268218AbTBYUtA>; Tue, 25 Feb 2003 15:49:00 -0500
Message-Id: <5.1.0.14.2.20030225125619.02015ce8@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 25 Feb 2003 12:58:57 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: [BK] Bluetooth updates for 2.4.21-pre4
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53L.0302251738170.16726@freak.distro.conectiva>
References: <20030224143729.GG27646@louise.pinerecords.com>
 <20030224143729.GG27646@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:38 PM 2/25/2003, Marcelo Tosatti wrote:

>On Mon, 24 Feb 2003, Tomas Szepe wrote:
>
>> It's been 4 weeks since 2.4.21-pre4 went out and the pre4->current
>> diff is over 3 megabytes.  Anything special holding off -pre5?
>>
>> I wouldn't be surprised if Alan had 100+ patches queued up
>> to be merged after a new tag release.
>
>I'm very late yes. I will release it today or tomorrow.

Before you do that could you please pull a couple of Bluetooth fixes from
        bk pull bk://linux-bt.bkbits.net/bt-2.4

This will update the following files:

 include/net/bluetooth/hci.h      |  104 +++++++++++++-------------
 include/net/bluetooth/hci_core.h |   12 +--
 net/bluetooth/hci_core.c         |  118 ++++++++++-------------------
 net/bluetooth/hci_sock.c         |  156 +++++++++++++++++++++------------------
 net/bluetooth/syms.c             |    6 -
 5 files changed, 191 insertions(+), 205 deletions(-)

through these ChangeSets:

<maxk@qualcomm.com> (03/01/27 1.884.1.113)
   [Bluetooth] Add support for vendor specific commands.
   All vendor commands are treated as raw data and 
   applications are responsible for flow control.


Thanks
Max

