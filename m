Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313941AbSDKAq6>; Wed, 10 Apr 2002 20:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313942AbSDKAq5>; Wed, 10 Apr 2002 20:46:57 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30197
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313941AbSDKAq5>; Wed, 10 Apr 2002 20:46:57 -0400
Date: Wed, 10 Apr 2002 17:49:11 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>,
        "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@zip.com.au>,
        Lennert Buytenhek <buytenh@gnu.org>
Subject: Re: [BUG] DEADLOCK when removing a bridge on 2.4.19-pre6
Message-ID: <20020411004911.GH23513@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	"David S. Miller" <davem@redhat.com>,
	Andrew Morton <akpm@zip.com.au>,
	Lennert Buytenhek <buytenh@gnu.org>
In-Reply-To: <20020410015311.GA31952@matchmail.com> <20020410181606.GD23513@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 11:16:06AM -0700, Mike Fedyk wrote:
> As requested by Jeff Garzik, I'm going to copy the latest tulip driver from
> 2.4.19-pre6 to 2.4.17 and test it there.  Lennert, I'll test the three
> bridgeing patches on top of that and let you know which one(s) cause the
> problem with bridge removal. 
> 

2.4.18_fix_port_state_handling.diff

Is causing the problem on 2.4.17-19p6tulip-br0fpsh.  I haven't tested the
other patches though.

I'm going to reverse this patch on 2.4.19-pre6 to see if it fixes it there
too.  Stay tuned.

Mike
