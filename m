Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262879AbVAKWGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbVAKWGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbVAKVmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:42:31 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:33603 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S262884AbVAKViP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:38:15 -0500
Date: Tue, 11 Jan 2005 15:38:00 -0600
From: DHollenbeck <dick@softplc.com>
Subject: Re: yenta_socket rapid fires interrupts
In-reply-to: <Pine.LNX.4.58.0501111143370.2373@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       magnus.damm@gmail.com
Message-id: <41E44738.2050606@softplc.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
References: <41E2BC77.2090509@softplc.com>
 <Pine.LNX.4.58.0501101857330.2373@ppc970.osdl.org>
 <41E42691.3060102@softplc.com>
 <Pine.LNX.4.58.0501111143370.2373@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add to my last post, the information that IRQ 11 is only being used by the two yenta sockets. So the "toggling" is not really toggling, but the printing of the two card sockets which are both on the same IRQ?

root@EMBEDDED[~]# cat /proc/interrupts
           CPU0
  0:    4039920          XT-PIC  timer
  2:          0          XT-PIC  cascade
  4:        167          XT-PIC  serial
  8:          0          XT-PIC  rtc
  9:       1633          XT-PIC  eth0
 11:     100000          XT-PIC  yenta, yenta
 14:      11209          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0


