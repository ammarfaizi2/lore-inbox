Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262028AbSIYRhS>; Wed, 25 Sep 2002 13:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262034AbSIYRhS>; Wed, 25 Sep 2002 13:37:18 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:34856 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262028AbSIYRhS>; Wed, 25 Sep 2002 13:37:18 -0400
Date: Wed, 25 Sep 2002 13:42:15 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: cmpxchg in 2.5.38
Message-ID: <20020925134215.A17831@devserv.devel.redhat.com>
References: <20020925120725.A23559@namesys.com> <Pine.LNX.4.44.0209251024580.4690-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209251024580.4690-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Sep 25, 2002 at 10:26:34AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I'll work around the cmpxchg locally.

But for the record, I am concerned with the API inflation
instigated by the single source. The scheduler-specific
bitmaps were bad enough, even though Bill Irvin showed
a better way to do it at the time. Now, the same gentleman
invents one more API. I may be getting senile, though.

-- Pete
