Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbVDPDpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbVDPDpD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 23:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVDPDpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 23:45:03 -0400
Received: from adsl-065-015-138-122.sip.mco.bellsouth.net ([65.15.138.122]:22667
	"EHLO mail.ultrawaves.com") by vger.kernel.org with ESMTP
	id S262608AbVDPDo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 23:44:59 -0400
Message-ID: <42608A35.5000609@lammerts.org>
Date: Fri, 15 Apr 2005 23:44:53 -0400
From: Eric Lammerts <eric@lammerts.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gabriel <gabriel.j@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting from USB with initrd
References: <28347315.1113550056435.JavaMail.tomcat@pne-ps4-sn1>
In-Reply-To: <28347315.1113550056435.JavaMail.tomcat@pne-ps4-sn1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gabriel wrote:
> Hi Im trying to boot an encrypted file system using an initrd on a USB. 
> I use syslinux for the actual boot process as I couldnt get Grub to boot
> of it for some reason. This is the .cfg

>  append initrd=/initrd.gz root=/dev/ram0 rootfstype=minix init=/linuxrc

I don't think syslinux digs the "/" in the initrd filename. Did you try 
it with initrd=initrd.gz?

Eric
