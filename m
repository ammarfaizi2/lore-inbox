Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266285AbUBLKsZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 05:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266327AbUBLKsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 05:48:25 -0500
Received: from relais.videotron.ca ([24.201.245.36]:41139 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S266285AbUBLKsX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 05:48:23 -0500
Date: Thu, 12 Feb 2004 05:43:03 -0500
From: Stephane Ouellette <ouellettes@videotron.ca>
Subject: [PATCH][COSMETIC[[2.4]  Remove double semicolon in arch/i386/mm/faulc.c
To: marcelo@logos.cnet
Cc: linux-kernel@vger.kernel.org
Message-id: <402B58B7.2000102@videotron.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_IY9NZW/AV/MOJ8Y98Y/DQQ)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_IY9NZW/AV/MOJ8Y98Y/DQQ)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Marcelo,

   the following patch removes a double semicolon in 
arch/i386/mm/fault.c for kernel 2.4.25-rc2.

Stephane Ouellette


--Boundary_(ID_IY9NZW/AV/MOJ8Y98Y/DQQ)
Content-type: text/plain; name=fault.c.patch; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=fault.c.patch

--- linux-2.4.25-rc2/arch/i386/mm/fault.c	2004-02-11 21:33:08.000000000 -0500
+++ linux-2.4.25-rc2-fixed/arch/i386/mm/fault.c	2004-02-11 21:34:55.000000000 -0500
@@ -71,7 +71,7 @@
 		if (!vma || vma->vm_start != start)
 			goto bad_area;
 		if (!(vma->vm_flags & VM_WRITE))
-			goto bad_area;;
+			goto bad_area;
 	}
 	return 1;
 

--Boundary_(ID_IY9NZW/AV/MOJ8Y98Y/DQQ)--
