Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132219AbRCVWVJ>; Thu, 22 Mar 2001 17:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132224AbRCVWVA>; Thu, 22 Mar 2001 17:21:00 -0500
Received: from fe040.world-online.no ([213.142.64.154]:58023 "HELO
	mail.world-online.no") by vger.kernel.org with SMTP
	id <S132219AbRCVWUr>; Thu, 22 Mar 2001 17:20:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Gerry <gerry@c64.org>
To: linux-kernel@vger.kernel.org
Subject: supermount ?
Date: Thu, 22 Mar 2001 23:21:07 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01032223210703.00829@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded my kernel to version 2.4.2, with no problems at all, 
except one: supermount. I guess you already know that supermount haven't been 
upgraded to support 2.4.2 or even 2.4 yet, and i guess there's nothing to do 
about that but wait. But that's not why i'm writing this.

Supermount sounds to me like a very important part of linux, at least for us 
who like our cds/dvds/etc. to work as easily as in fx. windows. For linux to 
be popular among "normal" users, it should be present at every system with 
local removable drives. So, my question is; why isn't supermount a standard 
part of the kernel, or at least a module ?

Right now i have to use autofs to manage automounting, but there's several 
problems with that (as it's aimed at use with network devices): Fx, it locks 
my dvd/cdrw-drives every time they get mounted, so that eject isn't possible 
until it gets unmounted. Floppy disks aren't updated until they're remounted. 
Setting low timeouts doesn't help at this, since it doesn't seem to work that 
well with local devices for some reason..

So, supermount is required even if autofs is included in the kernel, from my 
point of view anyway. I'm sure there's many people out there like me :)

Any chance supermount will be a standard kernel module in the future ?

Gerry
