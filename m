Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbUKTKjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbUKTKjm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 05:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUKTKjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 05:39:02 -0500
Received: from ems.hclinsys.com ([203.90.70.242]:32004 "EHLO ems.hclinsys.com")
	by vger.kernel.org with ESMTP id S261687AbUKTKgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 05:36:09 -0500
Subject: on the concept of COW
From: Jagadeesh Bhaskar P <jbhaskar@hclinsys.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1100947100.4038.41.camel@myLinux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 20 Nov 2004 16:08:21 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 When a process forks, every resource of the parent, including the
virtual memory is copied to the child process. The copying of VM uses
copy-on-write(COW). I know that COW comes when a write request comes,
and then the copy is made. Now my query follows:

How will the copy be distributed. Whether giving the child process a new
copy of VM be permanent or whether they will be merged anywhere? And
shouldn't the operations/updations by one process be visible to the
other which inherited the copy of the same VM?

How can this work? Can someone please help me on this regard?

-- 
With regards,

Jagadeesh Bhaskar P
R&D Engineer
HCL Infosystems Ltd
Pondicherry
INDIA

