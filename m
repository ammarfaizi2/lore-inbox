Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266854AbTAOSRK>; Wed, 15 Jan 2003 13:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266859AbTAOSRK>; Wed, 15 Jan 2003 13:17:10 -0500
Received: from [65.67.58.25] ([65.67.58.25]:49337 "EHLO duallie.mdrx.com")
	by vger.kernel.org with ESMTP id <S266854AbTAOSRJ>;
	Wed, 15 Jan 2003 13:17:09 -0500
From: Brian Jackson <brian@mdrx.com>
To: Adam Scislowicz <adams@fourelle.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 (ramdisk device naming at boot time(/dev/ramdisk/<n>) vs. after devfs is mounted(/dev/rd/<n>))
Date: Wed, 15 Jan 2003 12:29:16 -0600
User-Agent: KMail/1.5
References: <3E25A0D1.1020004@fourelle.com>
In-Reply-To: <3E25A0D1.1020004@fourelle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200301151229.16547.brian@mdrx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

devfsd.conf has some stuff in it about making symlinks. Maybe this would work 
for you. It is worth a look.

--Brian Jackson

On Wednesday 15 January 2003 11:56 am, Adam Scislowicz wrote:
> In the 2.4.20 kernel, when using DEVFS the ramdisk naming is
> inconsistent. /dev/ramdisk/0 works for the kernel parameter initrd=
> while /dev/rd/0 works in fstab.
> For clarity: before DEVFS loads it must be referenced as /dev/ramdisk/0,
> yet DEVFS registers /dev/rd/<n>
>
> /)dam.. .  . D o n ' t   S t o p
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

