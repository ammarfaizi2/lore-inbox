Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbVJMAGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVJMAGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVJMAGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:06:18 -0400
Received: from mail.shareable.org ([81.29.64.88]:64225 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S964822AbVJMAGR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:06:17 -0400
Date: Thu, 13 Oct 2005 01:05:46 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       Glauber de Oliveira Costa <glommer@br.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
Message-ID: <20051013000546.GC23770@mail.shareable.org>
References: <20051010204517.GA30867@br.ibm.com> <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk> <20051010214605.GA11427@br.ibm.com> <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz> <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz> <1129017155.12336.4.camel@imp.csi.cam.ac.uk> <434D6932.1040703@suse.com> <Pine.LNX.4.62.0510122155390.9881@artax.karlin.mff.cuni.cz> <434D6CFA.4080802@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434D6CFA.4080802@suse.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney wrote:
> No, it's not, and deadlock is definitely possible. However, if we're at
> the point where memory is tight enough that it's an issue, the timer can
> expire and all the pending i/o is dropped just as it would be without
> the multipath code enabled.

Followed by requesting a dialog to tell the user that their dirty
data/metadata has been dropped :)

-- Jamie
