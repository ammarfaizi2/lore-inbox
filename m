Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293604AbSCKE2x>; Sun, 10 Mar 2002 23:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293603AbSCKE2o>; Sun, 10 Mar 2002 23:28:44 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:25231 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S293600AbSCKE2c>; Sun, 10 Mar 2002 23:28:32 -0500
Date: Sun, 10 Mar 2002 23:28:24 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Michael Clark <michael@metaparadigm.com>
Cc: "David S. Miller" <davem@redhat.com>, whitney@math.berkeley.edu,
        rgooch@ras.ucalgary.ca, linux-kernel@vger.kernel.org
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
Message-ID: <20020310232824.A28854@redhat.com>
In-Reply-To: <20020310221530.A28821@redhat.com> <507C85FA-34A7-11D6-AD8C-000393843900@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <507C85FA-34A7-11D6-AD8C-000393843900@metaparadigm.com>; from michael@metaparadigm.com on Mon, Mar 11, 2002 at 12:20:26PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 12:20:26PM +0800, Michael Clark wrote:
> What about jumbo frames?  I notice this comment in the driver "disable
> jumbo frames to avoid tx hangs".  I'm getting ~550Mb/sec from a single
> TCP stream and ~700Mb/sec with 2 in parallel. Jumbo frames would
> probably improve this quite a bit.

Jumbo frames work up to RX_BUF_SIZE.  Hint: any mtu you try to specify 
that the driver lets you set should work.

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."
