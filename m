Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289394AbSAJK7k>; Thu, 10 Jan 2002 05:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289393AbSAJK7a>; Thu, 10 Jan 2002 05:59:30 -0500
Received: from hal.astr.lu.lv ([195.13.134.67]:6016 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S289389AbSAJK7O> convert rfc822-to-8bit;
	Thu, 10 Jan 2002 05:59:14 -0500
Message-Id: <200201101058.g0AAwJH00606@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: dledford@redhat.com, tom@infosys.tuwien.ac.at
Subject: i810_audio driver v0.19 still freezes machine
Date: Thu, 10 Jan 2002 12:58:19 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found that i810_audio driver v0.19 from 
	http://people.redhat.com/dledford/i810_audio.c.gz
still freezes machine after /dev/dsp is being closed 
(printk at end of i810_release()). It doesn't happen always though.

I did tests under KDE. artsd is setup to close /dev/dsp after being idle 
for 5 seconds. System rather often (but not always) freezes
after that.

Earlier v0.14 from
	http://www.infosys.tuwien.ac.at/Staff/tom/SiS7012/i810_audio-020105.c
doen't cause similar problems for me

Andris
