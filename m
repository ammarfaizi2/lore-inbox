Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261754AbSJCRIK>; Thu, 3 Oct 2002 13:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261756AbSJCRIK>; Thu, 3 Oct 2002 13:08:10 -0400
Received: from ns.suse.de ([213.95.15.193]:57093 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261754AbSJCRIJ>;
	Thu, 3 Oct 2002 13:08:09 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: Sequence of IP fragment packets on the wire
References: <anh7es$mpl$1@forge.intermeta.de.suse.lists.linux.kernel> <20021003.035352.132919623.davem@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Oct 2002 19:13:25 +0200
In-Reply-To: "David S. Miller"'s message of "3 Oct 2002 13:04:19 +0200"
Message-ID: <p73smznqwcq.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:
>    
>    Is there a way to configure this? Maybe even connection specific? 
> 
> No.

Actually there used to be an old netfilter module around (I think it was
one of the early netfilter demo modules) that reversed the fragments. Of 
course it is not efficient at all and not recommended.

-Andi
