Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVDUW1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVDUW1c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 18:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVDUW1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 18:27:32 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:59119 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261458AbVDUW0k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 18:26:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SvpX2Cvx0iuQakFgVnaqKKsyqvfcWJK8FB7dyiTBIxMqjaGSVQ2fI97PrfO4+c6HNkGn4dwXU8Qu3SrEEZ6Yb+/N3p7tkgmJ3QvcFhDhBeT1cCUVSR3zeSTNKyEPQIiJZcT25qmwm3nsREvglbxmP57MWeVY1j/d0gyzBKzqUi8=
Message-ID: <7f45d9390504211526277e83be@mail.gmail.com>
Date: Thu, 21 Apr 2005 15:26:37 -0700
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: lirc and Linux 2.6.11
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was using lirc 0.7.0 with Linux 2.6.8.1. Upon upgrading to Linux
2.6.11, I recompiled the lirc 0.7.0 hauppauge (lirc_i2c) modules for
the new kernel. This did not work. I then tried compiling the lirc
0.7.1 modules for the new kernel. This didn't work either. The error
message lircd gives is...

Apr 21 14:57:29 quince lircd 0.7.1: lircd(hauppauge) ready
Apr 21 14:57:52 quince lircd 0.7.1: accepted new client on /dev/lircd
Apr 21 14:57:52 quince lircd 0.7.1: could not open /dev/lirc0
Apr 21 14:57:52 quince lircd 0.7.1: default_init(): No such device
Apr 21 14:57:52 quince lircd 0.7.1: caught signal

I've also asked the lirc mailing list this question, but has anyone
else run into this trouble with lirc and Linux 2.6.11?

Please cc me in your reply. Thanks,
Shaun
