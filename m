Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271664AbRIGKNq>; Fri, 7 Sep 2001 06:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271665AbRIGKNh>; Fri, 7 Sep 2001 06:13:37 -0400
Received: from t2.redhat.com ([199.183.24.243]:59130 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S271664AbRIGKNT>; Fri, 7 Sep 2001 06:13:19 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.GSO.4.33.0109062315490.1190-100000@sweetums.bluetronic.net> 
In-Reply-To: <Pine.GSO.4.33.0109062315490.1190-100000@sweetums.bluetronic.net> 
To: Ricky Beam <jfbeam@bluetopia.net>
Cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: MTD and Adapter ROMs 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 Sep 2001 11:13:32 +0100
Message-ID: <7118.999857612@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jfbeam@bluetopia.net said:
> Has anyone tried adapting any of the MTD code to allow read/write
> access to adapter EEPROMs like the netboot ROM on some network cards
> -- or more to the point, HPT adapter cards? 

Should be relatively simple if you just provide the appropriate 'map' 
driver to access the flash and set the Vpp line when asked.

See drivers/mtd/maps/l440gx.c in my tree.

There's also the code at http://www.freiburg.linux.de/~stepan/bios/
which possibly ought to be merged with the MTD code.

--
dwmw2


