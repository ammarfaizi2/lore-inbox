Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132526AbRCZSTd>; Mon, 26 Mar 2001 13:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132525AbRCZST1>; Mon, 26 Mar 2001 13:19:27 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:43925 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S132538AbRCZSTN>; Mon, 26 Mar 2001 13:19:13 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Mon, 26 Mar 2001 11:18:01 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: 2.4.2-ac25 error: Malformed setting 'kernel.printk' after cs46xx load/unload
MIME-Version: 1.0
Message-Id: <01032611180100.00940@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got an error message on bootup and shutdown of 2.4.2-ac25 just after
loading and unloading the cs46xx module.  The error was not logged
to /var/log/messages, but I copied it from the screen.

On boot:

Loading sound module (cs46xx)
Loading mixer settings:
error: Malformed setting 'kernel.printk='

On shutdown:

Saving mixer settings:
Unloading sound module (cs46xx)
error: Malformed setting 'kernel.printk='

This is the first time I've seen this message.
It does not occur with -ac20 or earlier.

The sound still works just fine with 2.4.2-ac25. :)

Steven
