Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262249AbSJFW6R>; Sun, 6 Oct 2002 18:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSJFW6Q>; Sun, 6 Oct 2002 18:58:16 -0400
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:18656 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262249AbSJFW6P>; Sun, 6 Oct 2002 18:58:15 -0400
Message-ID: <3DA0C155.2070503@earthlink.net>
Date: Sun, 06 Oct 2002 18:03:49 -0500
From: "Steven W. Dover" <swdlinunx@earthlink.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] - 2.5.40 xconfig and CONFIG_PARPORT_PC_PCMCIA
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Via make xconfig, two entries show up even though
there is only one in the .config file, and you cannot
set the entry with xconfig even when CONFIG_PARPORT=y
and CONFIG_PARPORT_PC=y.  It is plain messed up.
make menuconfig does not have this problem.



