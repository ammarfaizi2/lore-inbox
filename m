Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752531AbWAFWag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbWAFWag (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbWAFWag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:30:36 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:29801 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1752531AbWAFWag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:30:36 -0500
Date: Fri, 6 Jan 2006 14:30:32 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-git2: CONFIGFS_FS shows up as M/y choice, help says "if unsure, say N"
Message-ID: <20060106223032.GZ18439@ca-server1.us.oracle.com>
Mail-Followup-To: Alessandro Suardi <alessandro.suardi@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5a4c581d0601061310j3f4eb310o1d68c0b87c278685@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4c581d0601061310j3f4eb310o1d68c0b87c278685@mail.gmail.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 10:10:13PM +0100, Alessandro Suardi wrote:
> If unsure, say N.
> ===========
> 
> I think I'll say M - for now ;)

	If you choose something depending on CONFIGFS_FS, you of course
don't get the choice of 'N'.  Here's a cleanup also available at
http://oss.oracle.com/git/ocfs2-dev.git

Joel

o Remove confusing help text.

Signed-off-by: Joel Becker <joel.becker@oracle.com>

---

 fs/Kconfig |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

a6bd5f413af39c5efb028766c1a032cded820a69
diff --git a/fs/Kconfig b/fs/Kconfig
index 382e3b2..7b80937 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -883,8 +883,6 @@ config CONFIGFS_FS
 	  Both sysfs and configfs can and should exist together on the
 	  same system. One is not a replacement for the other.
 
-	  If unsure, say N.
-
 endmenu
 
 menu "Miscellaneous filesystems"
-- 
1.0.6

-- 

Life's Little Instruction Book #306

	"Take a nap on Sunday afternoons."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
