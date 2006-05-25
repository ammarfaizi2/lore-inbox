Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWEYQXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWEYQXj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWEYQXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:23:39 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:33749 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1030242AbWEYQXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:23:38 -0400
Date: Thu, 25 May 2006 13:23:36 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.17-rc5
Message-ID: <20060525132336.7f6ca8af@doriath.conectiva>
In-Reply-To: <Pine.LNX.4.64.0605241902520.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605241902520.5623@g5.osdl.org>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.0 (GTK+ 2.8.17; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2006 19:09:28 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

| 
| Ok,
|  there it is in all the normal places (or will be, once mirroring 
| finishes).
| 
| It's mainly drivers updates (firewire sbp2 driver, infiniband ipath 
| driver, some DVB updates, and some mmc, network, spi and usb driver 
| stuff).
| 
| But there's a few netfilter and sctp updates too, and various random 
| one-liners around.. As usual, the shortlog is pretty readable, and gives a 
| reasonable view into the details.
| 
| This will hopefully be the last -rc before the final 2.6.17, knock wood..

 I'm getting this after running 'halt':

Halting system...
md: stopping all md devices.
md: md0 switched to read-only mode.
Shutdown: hda
System halted.
BUG: halt/3367, lock held at task exit time!
 [dfe70494] {mddev_find}
.. held by:              halt: 3367 [decf4a90, 118]
... acquired at:               md_notify_reboot+0x31/0x7f

-- 
Luiz Fernando N. Capitulino
