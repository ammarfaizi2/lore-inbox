Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310699AbSCMP71>; Wed, 13 Mar 2002 10:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310703AbSCMP7G>; Wed, 13 Mar 2002 10:59:06 -0500
Received: from [12.150.248.132] ([12.150.248.132]:44185 "EHLO
	dhcp-177.hsv.redhat.com") by vger.kernel.org with ESMTP
	id <S310699AbSCMP6x>; Wed, 13 Mar 2002 10:58:53 -0500
Date: Wed, 13 Mar 2002 09:58:32 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: "Tim McDaniel" <tim.mcdaniel@tuxia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 Block Driver and mmap
Message-Id: <20020313095832.5f9f3074.reynolds@redhat.com>
In-Reply-To: <A16915712C18BD4EBD97897F82DA08CD409F56@exchange1.win.agb.tuxia>
In-Reply-To: <A16915712C18BD4EBD97897F82DA08CD409F56@exchange1.win.agb.tuxia>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
X-Message-Flag: Outlook Virus Warning: Reboot within 12 seconds or risk loss of all files and data!
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uttered "Tim McDaniel" <tim.mcdaniel@tuxia.com>, spoke thus:

>  I'm porting a working 2.2 driver to 2.4 .   Unfortunately, the mmap
>  entry point is not defined in the block_device_operations.

You can't just frob around with this.  2.2 is not 2.4, so first check this:

	http://www.xml.com/ldd/chapter/book/index.html

for Rubini and Corbets Linux Device Drivers, 2nd Ed.  Buy a copy.
