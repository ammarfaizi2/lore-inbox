Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTJQR4g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 13:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTJQR4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 13:56:36 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:19817 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263573AbTJQR4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 13:56:35 -0400
Subject: ICH5 - CMI9739A - AC'97 sound driver support
From: Saravanan Subbiah <saravanan_subbiah@sbcglobal.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1066413060.13867.24.camel@dude.saravan.dns2go.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3.99 
Date: Fri, 17 Oct 2003 10:51:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to make sound work in my motherboard with CMI9739A chipset.

The driver from c-media works but freezes my SMP (HT) kernel.

So I tried the i810_audio driver in 2.4.22-ac4 kernel. This driver works
but I cannot change the volume. It always outputs at high volume
irrespective what level I set.

I even tried alsa driver snd-intel8x0 and got the same result. no volume
control support.'

I read somewhere that this is a basic deficiency in the codec and that
the driver has to "something special" to achieve this ? Is it true ?
Is someone looking into this ?

If someone can give me some pointers, I can look into this.

thanks,
Saravanan

