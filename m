Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261942AbRF0ODO>; Wed, 27 Jun 2001 10:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261881AbRF0ODE>; Wed, 27 Jun 2001 10:03:04 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:48844 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261942AbRF0OCy>; Wed, 27 Jun 2001 10:02:54 -0400
Importance: Normal
Subject: printk and sk_buffs
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.6  December 14, 2000
Message-ID: <OFC7C24EA9.6CB8EE5C-ONC1256A78.004CC2C0@de.ibm.com>
From: "Jens Hoffrichter" <HOFFRICH@de.ibm.com>
Date: Fri, 27 Jul 2001 16:02:40 +0200
X-MIMETrack: Serialize by Router on d12ml040/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 27/06/2001 16:02:41
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I do not fully unterstandt the printk code, so perhaps somebody can answer
me this (probably stupid ;) ) question:

If I do a printk, is there a packet (aka a sk_buff) created? If I turn on
debugging in my code, I see a huge pile of sk_buffs which are allocated but
which do not get in touch with the "essential" parts of the network-code
(e.g. ip_rcv) where I have modified some code. I can't explain it to me
fully, but perhaps someone of yours has a suitable answer.

Thanks in advance.

Regards,
Jens Hoffrichter

