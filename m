Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262792AbSLIERp>; Sun, 8 Dec 2002 23:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbSLIERp>; Sun, 8 Dec 2002 23:17:45 -0500
Received: from dp.samba.org ([66.70.73.150]:4305 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262792AbSLIERn>;
	Sun, 8 Dec 2002 23:17:43 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50bk5 cannot insert module aha152x 
In-reply-to: Your message of "Fri, 06 Dec 2002 14:36:31 BST."
             <5.2.0.9.0.20021206141716.00a09df0@mail.science.uva.nl> 
Date: Mon, 09 Dec 2002 10:30:01 +1100
Message-Id: <20021209042524.0C6DB2C382@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <5.2.0.9.0.20021206141716.00a09df0@mail.science.uva.nl> you write:
> Hi,
> 
> I get this error when I try to load the aha152x module:
> # modprobe aha152x io=0x140 irq=9
> FATAL: Error inserting aha152x (/lib/modules/2.5.50bk5/kernel/aha152x.ko): 
> No such device

Linus still hasn't taken the parameter patches, which is the first
reason this won't work.

> and this message appears in dmesg:
> scsi HBA driver Adaptec 152x SCSI driver; $Revision: 2.5 $ didn't set 
> max_sectors, please fix the template
> 
> Is this trivial to fix or has something fundamental changed?

Don't know this one...

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
