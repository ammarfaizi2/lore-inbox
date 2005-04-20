Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVDTVMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVDTVMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 17:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVDTVMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 17:12:48 -0400
Received: from zaphod.axian.com ([64.122.196.146]:25744 "EHLO zaphod.axian.com")
	by vger.kernel.org with ESMTP id S261815AbVDTVMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 17:12:39 -0400
Date: Wed, 20 Apr 2005 14:12:38 -0700
From: Alice Corbin <ali@axian.com>
To: linux-kernel@vger.kernel.org
Subject: video drivers, agp, mtrr, and write-combining
Message-ID: <20050420211238.GA15379@zaphod.axian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a silly question.

I've noticed that some, though no all, video drivers add their video memory
to MTRR as 'write-combining' if both MTRR and AGP are configured in.

Is there a reason that all video drivers don't do this?  Is it all would 
benefit from write-combining memory, but that some simply haven't been 
updated to take advantage of it?  Or could write-combining actually be 
detrimental to some video drivers?  (And if the former, would it make
more sense to do the mtrr_add in a central location, say agpgart?)

Ali
