Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285113AbRLLJQ3>; Wed, 12 Dec 2001 04:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285114AbRLLJQT>; Wed, 12 Dec 2001 04:16:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:19328 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285113AbRLLJQM>;
	Wed, 12 Dec 2001 04:16:12 -0500
Date: Wed, 12 Dec 2001 01:15:59 -0800 (PST)
Message-Id: <20011212.011559.21594482.davem@redhat.com>
To: axboe@suse.de
Cc: anton@samba.org, plars@austin.ibm.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Scsi problems in 2.5.1-pre9
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011212090253.GR13498@suse.de>
In-Reply-To: <20011211221747.GB30520@krispykreme>
	<20011211.142714.115908324.davem@redhat.com>
	<20011212090253.GR13498@suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jens Axboe <axboe@suse.de>
   Date: Wed, 12 Dec 2001 10:02:53 +0100
   
   Dave nailed this bug, Anton you'll want to apply it before testing :-)
   It fixes a case of too much copy'n paste with back merges +
   DMA_CHUNK_SIZE enabled.

There still are problems even after this fix.

In fact the failures look identical to what I was seeing
before, first dbench from single user is insta-crash.
