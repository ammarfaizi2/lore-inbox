Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265262AbSJWWNo>; Wed, 23 Oct 2002 18:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265263AbSJWWNo>; Wed, 23 Oct 2002 18:13:44 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:9259 "EHLO alpha.stev.org")
	by vger.kernel.org with ESMTP id <S265262AbSJWWNn>;
	Wed, 23 Oct 2002 18:13:43 -0400
Subject: Re: One for the Security Guru's
From: James Stevenson <james@stev.org>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021023130251.GF25422@rdlg.net>
References: <20021023130251.GF25422@rdlg.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 23 Oct 2002 23:15:14 +0100
Message-Id: <1035411315.5377.8.camel@god.stev.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   The consultants aparantly told the company admins that kernel modules
> were a massive security hole and extremely easy targets for root kits.
> As a result every machine has a 100% monolithic kernel, some of them
> ranging to 1.9Meg in filesize.  This of course provides some other
> sticky points such as how to do a kernel boot image.

i very much doubt this would stop anyone who really wanted todo
something like loading a module.

Stating something like that would also mean booting the kernel from
a disk inside the machine is also insecure.

As to load a module you must be root and if you are root you
can read / write disks. Thus you could recompile your own kernel
install it try to force a crash or a reboot which is not hard as root
and the person may not even notice that the kernel has grown by a few
bytes after the crash.

The only thing it may do is slow somebody down.
A lot of people out there if they can get access to a system
and cannot keep it will also tend todo a rm -rfv /
or equivelent nasty.

	James

