Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261464AbSIZAZ6>; Wed, 25 Sep 2002 20:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261474AbSIZAZ6>; Wed, 25 Sep 2002 20:25:58 -0400
Received: from ns.suse.de ([213.95.15.193]:44807 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261464AbSIZAZ5>;
	Wed, 25 Sep 2002 20:25:57 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: niv@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
References: <3D924F9D.C2DCF56A@us.ibm.com.suse.lists.linux.kernel> <20020925.170336.77023245.davem@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 26 Sep 2002 02:31:13 +0200
In-Reply-To: "David S. Miller"'s message of "26 Sep 2002 02:11:21 +0200"
Message-ID: <p73n0q5sib2.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:
>    
> In fact the exact opposite, such a suggested flow cache is about
> as parallel as you can make it.

It sounds more like it would include the FIB too.

> I don't understand why you think using the routing tables to their
> full potential would imply serialization.  If you still believe this
> you have to describe why in more detail.

I guess he's thinking of the FIB, not the routing cache.

The current FIBs have a bit heavier locking at least. Fine grain locking
btrees is also not easy/nice.

-Andi

