Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277605AbRJRFxt>; Thu, 18 Oct 2001 01:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277601AbRJRFxk>; Thu, 18 Oct 2001 01:53:40 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:49543 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S277231AbRJRFxV>;
	Thu, 18 Oct 2001 01:53:21 -0400
Message-ID: <3BCE6E6E.3DD3C2D6@candelatech.com>
Date: Wed, 17 Oct 2001 22:53:50 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
In-Reply-To: <15310.25406.789271.793284@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> Hi,
>  In my ongoing effort to provide centralised file storage that I can
>  be proud of, I have put together some code to implement tree quotas.
> 
>  The idea of a tree quota is that the block and inode usage of a file
>  is charged to the (owner of the root of the) tree rather than the
>  owner (or group owner) of the file.
>  This will (I hope) make life easier for me.  There are several
>  reasons that I have documented (see URL below) but a good one is that
>  they are transparent and predictable.  du -s $HOME should *always*
>  match your usage according to "quota".

Err, except maybe when you also own a file in /home/idiot/idiots_unprotected_storage_dir
(This relates not at all to your patch/comments.)

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
