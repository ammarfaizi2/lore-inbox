Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277700AbRJ1FCO>; Sun, 28 Oct 2001 01:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277702AbRJ1FCE>; Sun, 28 Oct 2001 01:02:04 -0400
Received: from cogito.cam.org ([198.168.100.2]:9734 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S277700AbRJ1FB5>;
	Sun, 28 Oct 2001 01:01:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@CAM.ORG>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: 2.4.14-pre3 and umount
Date: Sun, 28 Oct 2001 00:57:41 -0400
X-Mailer: KMail [version 1.3.2]
Cc: reiserfs-list@namesys.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011028045744.BE5C22A109@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am running 2.4.14-pre3 patched with LVM 1.01rc4 and the vfs locking patch
for 2.4.11 and above.  I performed the following actions after which umount
fails.

mount /back
cd /back
ran a backup which filled the reiserfs on lvm /back fs.
cd ..
umount /back

and the umount tells me /back is busy.  Why? Does anyone 
else see this behavior?  With straight 2.4.14-pre3?

TIA,
Ed Tomlinson (off to sleep now)
