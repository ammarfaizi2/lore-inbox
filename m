Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbUL2NzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbUL2NzR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 08:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbUL2NzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 08:55:16 -0500
Received: from unthought.net ([212.97.129.88]:35019 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261348AbUL2NzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 08:55:11 -0500
Date: Wed, 29 Dec 2004 14:55:10 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: "Fao, Sean" <sean.fao@capitalgenomix.com>
Cc: Vladimir Saveliev <vs@namesys.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem/kernel bug?
Message-ID: <20041229135510.GQ347@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	"Fao, Sean" <sean.fao@capitalgenomix.com>,
	Vladimir Saveliev <vs@namesys.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <41D02F54.8070107@capitalgenomix.com> <41D16500.9070903@capitalgenomix.com> <1104251242.3568.30.camel@tribesman.namesys.com> <41D2A8FC.7080604@capitalgenomix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D2A8FC.7080604@capitalgenomix.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2004 at 07:54:20AM -0500, Fao, Sean wrote:
...
> 
> Vladimir,
> 
> Thank you much for your response.  This is a production email server so 
> I had to wait for an appropriate time to shut the system down.
> 
> Just a quick summary of what happened.  After rebooting the sever and 
> booting from a CD, I ran reiserfsck, which found no corruption in the 
> file system.  I then manually checked the directory structure and 
> everything looked fine.  I'm not what was wrong, but a reboot apparently 
> corrected whatever it was.

I've seen this on ext3 and XFS as well.

Both locally (ext3 and XFS) and NFS exported (XFS).

About to try out 2.6.10 with CVS XFS and patches from the list - but
somehow I doubt that the actual problem is in the filesystems.

-- 

 / jakob

