Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbQKARmv>; Wed, 1 Nov 2000 12:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129804AbQKARml>; Wed, 1 Nov 2000 12:42:41 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:51730 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129092AbQKARm1>; Wed, 1 Nov 2000 12:42:27 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDBEC@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Heusden, Folkert van'" <f.v.heusden@ftr.nl>,
        "'Linux Kernel Development'" <linux-kernel@vger.kernel.org>
Subject: RE: fork in module?
Date: Wed, 1 Nov 2000 09:42:12 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x = kernel_thread(&func, &arg, flags);

might do what you want.

~Randy_________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
----------------------------------------------- 

> From: Heusden, Folkert van [mailto:f.v.heusden@ftr.nl]
> 
> what would be the way of starting a sub-process in a module 
> which then would
> run in the background? I guess plain fork() won't work?
> -

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
