Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbVCCVgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbVCCVgM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbVCCVdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:33:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12719 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262525AbVCCVbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:31:42 -0500
Message-ID: <4227821F.1080700@pobox.com>
Date: Thu, 03 Mar 2005 16:31:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, Andries Brouwer <aebr@win.tue.nl>,
       davem@davemloft.net, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       notting@redhat.com
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org> <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net> <20050303011151.GJ10124@redhat.com> <20050302172049.72a0037f.akpm@osdl.org> <20050303012707.GK10124@redhat.com> <20050303145846.GA5586@pclin040.win.tue.nl> <20050303130901.655cb9c4.akpm@osdl.org> <20050303212115.GJ29371@redhat.com>
In-Reply-To: <20050303212115.GJ29371@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> Other failures have been somewhat more dramatic.
> I know ipsec-tools, and alsa-lib have both caused pain
> on at least one occasion after the last 2-3 kernel updates.


alsa-lib is a special case.

alsa-lib exists so that it can mitigate changes between the kernel and 
userland.  If the kernel API changes, alsa-lib may need to be updated, 
but not all the apps using alsa-lib.

Someone needs to put alsa-lib updating on the list of stuff to do when 
updating the kernel...

	Jeff


