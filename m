Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262400AbSI2GVZ>; Sun, 29 Sep 2002 02:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262401AbSI2GVZ>; Sun, 29 Sep 2002 02:21:25 -0400
Received: from web14606.mail.yahoo.com ([216.136.224.86]:33801 "HELO
	web14606.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262400AbSI2GVY>; Sun, 29 Sep 2002 02:21:24 -0400
Message-ID: <20020929062646.97364.qmail@web14606.mail.yahoo.com>
Date: Sat, 28 Sep 2002 23:26:46 -0700 (PDT)
From: Arvind Gopalan <arvind_gopalan@yahoo.com>
Subject: 4 byte mem alignment
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wished someone to confirm the following: Is it a
requirement for the user space buffer that is provided
to the recvfrom() socket call, be 4 byte aligned?.
Note that sockets are raw sockets (PF_PACKET type). I
am running linux 2.4.18-10 on a dual xeon P4 (x86)
box. At the lowest level, i think this translates to
how strong the requirements are for copy_to_user().
does it fault to byte-by-byte mode gracefully when
given a non-4byte aligned buffer?.

Please include me in all replies, since i'm not
subscribed to the list

Thanks
-Arvind

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
