Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262933AbUKRVFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbUKRVFV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbUKRVD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:03:27 -0500
Received: from hal-5.inet.it ([213.92.5.24]:55786 "EHLO hal-5.inet.it")
	by vger.kernel.org with ESMTP id S261164AbUKRVDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:03:12 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: 2.6.10-rc2-mm2 usb storage still oopses
Date: Thu, 18 Nov 2004 22:03:01 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411182203.02176.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a reminder: it's possible to cause a kernel oops simply inserting and 
removing a usb storage (flash pen); using ub driver doesn't improve the 
situation; noticed in 2.6.9-rc4-mm1 and present in 2.6.10-rc2-mm2.
The same device works just fine with 2.6.8.1 (mdk cooker)
I can provide, as previously done, full log for oopses and other details, just 
let me known. (the behaviour is quite the same as already reported, so I 
don't want to waste bandwidth)

-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
