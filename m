Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263994AbTDJNOg (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 09:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264038AbTDJNOg (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 09:14:36 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:33677 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S263994AbTDJNOf (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 09:14:35 -0400
Subject: More CIFS problems in 2.5.67
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Steven French <sfrench@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049981172.11152.7.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Apr 2003 15:26:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm back with more problems :)

I think I got this when maintenance work on the network disconnected me
from the server (wasn't home at the time, only saw it in logs later and
I know it wasn't there before I left)

No other CIFS messages or generic kernel errors before this.


 CIFS VFS: Send error in Close = -5
 CIFS VFS: There are still active MIDs in queue and we are exiting but we can not delete mid_q_entries or TCP_Server_Info structure due to pending requests MEMORY LEAK!!
 CIFS VFS: CIFS: caught signal
 CIFS VFS: CIFS: caught signal
 CIFS VFS: CIFS: caught signal
 CIFS VFS: CIFS: caught signal
 CIFS VFS: CIFS: caught signal
 CIFS VFS: Error 0xfffffffb or (-5 decimal) on cifs_get_inode_info in lookup
 CIFS VFS: Error 0xfffffffb or (-5 decimal) on cifs_get_inode_info in lookup
 CIFS VFS: Error 0xfffffffb or (-5 decimal) on cifs_get_inode_info in lookup

Accessing or unmounting the fs just hangs but is interruptible.

-- 
/Martin
