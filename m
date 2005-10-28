Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbVJ1TEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVJ1TEa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbVJ1TEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:04:30 -0400
Received: from imo-d04.mx.aol.com ([205.188.157.36]:65171 "EHLO
	imo-d04.mx.aol.com") by vger.kernel.org with ESMTP id S1750824AbVJ1TE3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:04:29 -0400
From: AndyLiebman@aol.com
Message-ID: <190.4ba4a2cb.3093d02a@aol.com>
Date: Fri, 28 Oct 2005 15:04:10 EDT
Subject: What happened to XFS Quota Support?
To: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: 9.0 Security Edition for Windows sub 2340
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In previous Linux kernels -- 2.6.13 and below --  XFS quota could be set 
"statically" -- that is, in "make xconfig" you could put  a "check mark" in the 
XFS_quota support box even though you had a "dot" (module)  in the Overall 
XFS_Filesystem support box . 

In 2.6.14, not only has XFS  support moved under filesystems with all the 
other filesystems, but you can no  longer put a "checkmark" in the "quota 
support" box if you compile XFS support  as a module. 

Is this by design? Looking back at all of my past kernels,  xfs is enabled as 
a module but quota support is enabled statically. This is how  config files 
have been coming from Mandrake for at least the past year.  

Is there a reason why this option is no longer available? If you compile  
xfs_quota as a module, how do you load it? 

Andy  

