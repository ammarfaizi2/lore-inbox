Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264477AbUEJC7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbUEJC7s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 22:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbUEJC7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 22:59:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60864 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S264477AbUEJC7d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 22:59:33 -0400
Date: Sun, 09 May 2004 22:57:48 -0400
From: Stephane Ouellette <ouellettes@videotron.ca>
Subject: [COSMETIC][2.4.27-pre2]  Remove extra semicolumn in
 arch/i386/mm/fault.c
To: davej@suse.de
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <409EEFAC.705@videotron.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_EaLTKai/col7bqOLC+F6kQ)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_EaLTKai/col7bqOLC+F6kQ)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Dave,

   the following patch removes an extra semicolumn in 
arch/i386/mm/fault.c.  The patch applies to kernel 2.4.27-pre2.

Regards,

Stephane Ouellette.


--Boundary_(ID_EaLTKai/col7bqOLC+F6kQ)
Content-type: text/plain; name=fault.c.patch; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=fault.c.patch

--- linux-2.4.27-pre2/arch/i386/mm/fault.c	Sun May  9 22:23:22 2004
+++ linux-2.4.27-pre2-fixed/arch/i386/mm/fault.c	Sun May  9 22:29:42 2004
@@ -71,7 +71,7 @@
 		if (!vma || vma->vm_start != start)
 			goto bad_area;
 		if (!(vma->vm_flags & VM_WRITE))
-			goto bad_area;;
+			goto bad_area;
 	}
 	return 1;
 

--Boundary_(ID_EaLTKai/col7bqOLC+F6kQ)--
