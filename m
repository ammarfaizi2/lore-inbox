Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285118AbRLLJWT>; Wed, 12 Dec 2001 04:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285121AbRLLJWL>; Wed, 12 Dec 2001 04:22:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47374 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285118AbRLLJV6>;
	Wed, 12 Dec 2001 04:21:58 -0500
Date: Wed, 12 Dec 2001 10:21:48 +0100
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: anton@samba.org, plars@austin.ibm.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Scsi problems in 2.5.1-pre9
Message-ID: <20011212092148.GW13498@suse.de>
In-Reply-To: <20011211221747.GB30520@krispykreme> <20011211.142714.115908324.davem@redhat.com> <20011212090253.GR13498@suse.de> <20011212.011559.21594482.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011212.011559.21594482.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12 2001, David S. Miller wrote:
>    From: Jens Axboe <axboe@suse.de>
>    Date: Wed, 12 Dec 2001 10:02:53 +0100
>    
>    Dave nailed this bug, Anton you'll want to apply it before testing :-)
>    It fixes a case of too much copy'n paste with back merges +
>    DMA_CHUNK_SIZE enabled.
> 
> There still are problems even after this fix.
> 
> In fact the failures look identical to what I was seeing
> before, first dbench from single user is insta-crash.

DMA_CHUNK_SIZE only, or regardless?

-- 
Jens Axboe

