Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbSKFBmP>; Tue, 5 Nov 2002 20:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbSKFBmP>; Tue, 5 Nov 2002 20:42:15 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:19728 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265475AbSKFBmE>;
	Tue, 5 Nov 2002 20:42:04 -0500
Date: Tue, 5 Nov 2002 17:44:45 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI hotplug changes for 2.5.46
Message-ID: <20021106014444.GX18627@kroah.com>
References: <20021106013615.GQ18627@kroah.com> <20021106013708.GR18627@kroah.com> <20021106013741.GS18627@kroah.com> <20021106013835.GT18627@kroah.com> <20021106013915.GU18627@kroah.com> <20021106014304.GV18627@kroah.com> <20021106014358.GW18627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106014358.GW18627@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.875.1.7, 2002/11/02 23:40:07-08:00, greg@kroah.com

[PATCH] PCI Hotplug: removed a compiler warning of a unused variable in the cpcihp_generic driver.


diff -Nru a/drivers/hotplug/cpcihp_generic.c b/drivers/hotplug/cpcihp_generic.c
--- a/drivers/hotplug/cpcihp_generic.c	Tue Nov  5 17:26:02 2002
+++ b/drivers/hotplug/cpcihp_generic.c	Tue Nov  5 17:26:02 2002
@@ -63,7 +63,6 @@
 
 /* local variables */
 static int debug;
-static int setup;
 static char* bridge;
 static u8 bridge_busnr;
 static u8 bridge_slot;
