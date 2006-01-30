Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWA3JTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWA3JTU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWA3JTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:19:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:3468 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932155AbWA3JTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:19:19 -0500
Date: Mon, 30 Jan 2006 20:19:08 +1100
From: Nathan Scott <nathans@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
Subject: Re: reinitializing quota on xfs
Message-ID: <20060130201908.A8865130@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.61.0601291204380.18492@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0601291204380.18492@yvahk01.tjqt.qr>; from jengelh@linux01.gwdg.de on Sun, Jan 29, 2006 at 12:07:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 12:07:51PM +0100, Jan Engelhardt wrote:
> Hi,
> 
> for some strange reason, `quota -v` showed an impossible number in the 
> inodes (files) field, something that resembled 2^64 - n, n={1..100}. I do 

It would be really good if we could get a test case for this; it
gets reported once in a blue moon, so there does seem to be some
latent issue there...

> not know how it happened, but I wanted to reinitialize the quota. Though, 
> how does one do that with XFS? (Since it's different from the vfsv0 quota 
> architecture.)

See xfs_quota(8) from recent versions of xfsprogs, or in older
ones theres doco in /usr/share/doc/xfsprogs*/README.quota.

cheers.

-- 
Nathan
