Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262700AbSJGT7u>; Mon, 7 Oct 2002 15:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262693AbSJGT7m>; Mon, 7 Oct 2002 15:59:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34204 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262699AbSJGT6u>;
	Mon, 7 Oct 2002 15:58:50 -0400
Date: Mon, 07 Oct 2002 12:57:40 -0700 (PDT)
Message-Id: <20021007.125740.65911392.davem@redhat.com>
To: zaitcev@redhat.com
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: Linux v2.5.41
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200210072001.g97K1p726546@devserv.devel.redhat.com>
References: <mailman.1034018941.1657.linux-kernel2news@redhat.com>
	<200210072001.g97K1p726546@devserv.devel.redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pete Zaitcev <zaitcev@redhat.com>
   Date: Mon, 7 Oct 2002 16:01:51 -0400

   > David S. Miller <davem@redhat.com>:
   >   o USB: usbkbd fix
   
   Dave, why do you even bother with usbkbd? It MUST DIE and get
   removed. Please, do me a favour: kill CONFIG_USB_KBD from your
   configuration and let me and Vojtech know if something
   actually fails. The hid must support all devices which were
   supported bye usbkbd.

Peter, first relax. :-)

Second, I was merely fixing a build error reported by a user.

I personally use USB HID, but as long as USBKBD sits in the tree, it
should at least build.
