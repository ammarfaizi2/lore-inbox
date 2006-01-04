Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751545AbWADGc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbWADGc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 01:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbWADGc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 01:32:56 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:6864 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751545AbWADGcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 01:32:54 -0500
Date: Wed, 4 Jan 2006 01:32:51 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Subject: __getname vs kmalloc
Message-ID: <20060104063251.GA4263@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Which is the prefered method of allocating memory __getname or kmalloc?

I looked at the source, and it appears to be used by 9p, smbfs, parts
of VFS. In total there are only 10 calls to it.

Thanks,

Jeff Sipek.
