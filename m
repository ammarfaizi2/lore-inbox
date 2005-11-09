Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161064AbVKIW72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbVKIW72 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbVKIW72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:59:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42979 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161064AbVKIW71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:59:27 -0500
Date: Wed, 9 Nov 2005 14:58:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org,
       James.Bottomley@steeleye.com, len.brown@intel.com, jgarzik@pobox.com,
       tony.luck@intel.com, bcollins@debian.org, scjody@modernduck.com,
       dwmw2@infradead.org, rolandd@cisco.com, davej@codemonkey.org.uk,
       axboe@suse.de, shaggy@austin.ibm.com, sfrench@us.ibm.com
Subject: Re: merge status
In-Reply-To: <20051109144801.1acb53ad.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0511091456530.4627@g5.osdl.org>
References: <20051109133558.513facef.akpm@osdl.org>
 <Pine.LNX.4.64.0511092203320.19282@hermes-1.csi.cam.ac.uk>
 <20051109144801.1acb53ad.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Nov 2005, Andrew Morton wrote:
> 
> Ah, sorry, that appears to be all changelog noise coming out of
> `git log origin..git-ntfs'

You can use the "--no-merges" flag to git log to tell it to ignore merges.

(Of course, sometimes the merges themselves are interesting, so it's a 
matter of taste. In the specific case of the -mm logic, I suspect the 
merges aren't of interest and you're probably better off ignoring them).

			Linus
