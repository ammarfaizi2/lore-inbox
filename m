Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269167AbUIBWjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269167AbUIBWjG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269158AbUIBWfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:35:46 -0400
Received: from ned.cc.purdue.edu ([128.210.189.24]:16768 "EHLO
	ned.cc.purdue.edu") by vger.kernel.org with ESMTP id S269153AbUIBWcn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:32:43 -0400
From: Patrick Finnegan <pat@computer-refuge.org>
To: linux-kernel@vger.kernel.org
Subject: BUG in smbfs
Date: Thu, 2 Sep 2004 17:32:38 -0500
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409021732.38622.pat@computer-refuge.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that smbfs in 2.6.x (tested on 2.6.5, 2.6.7, and 2.6.8.1) no 
longer honors the uid= and gid= options, as it did in 2.4.x.

Is this by-design, or has something accidentally changed?

Pat
-- 
Purdue University ITAP/RCS        ---  http://www.itap.purdue.edu/rcs/
The Computer Refuge               ---  http://computer-refuge.org
