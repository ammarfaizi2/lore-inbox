Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313943AbSDKBDC>; Wed, 10 Apr 2002 21:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313944AbSDKBDB>; Wed, 10 Apr 2002 21:03:01 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:28407
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313943AbSDKBDB>; Wed, 10 Apr 2002 21:03:01 -0400
Date: Wed, 10 Apr 2002 18:05:15 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>,
        "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@zip.com.au>,
        Lennert Buytenhek <buytenh@gnu.org>
Subject: Re: [BUG] DEADLOCK when removing a bridge on 2.4.19-pre6
Message-ID: <20020411010515.GI23513@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	"David S. Miller" <davem@redhat.com>,
	Andrew Morton <akpm@zip.com.au>,
	Lennert Buytenhek <buytenh@gnu.org>
In-Reply-To: <20020410015311.GA31952@matchmail.com> <20020410181606.GD23513@matchmail.com> <20020411004911.GH23513@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 05:49:11PM -0700, Mike Fedyk wrote:
> 2.4.18_fix_port_state_handling.diff
> 
> Is causing the problem on 2.4.17-19p6tulip-br0fpsh.  I haven't tested the
> other patches though.
> 
> I'm going to reverse this patch on 2.4.19-pre6 to see if it fixes it there
> too.  Stay tuned.

2.4.18_enslave_bridge_dev_to_bridge_dev.diff

Is fine I didn't reproduce the trouble in 2.4.17-19p6tulip-br0ebdtbd (it was
already compiling when I tested the port_state kernel...).

2.4.19-pre6-nobr0fpsh building now...

Mike
