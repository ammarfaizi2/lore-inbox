Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSG3Tu7>; Tue, 30 Jul 2002 15:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316185AbSG3Tu7>; Tue, 30 Jul 2002 15:50:59 -0400
Received: from mnh-1-19.mv.com ([207.22.10.51]:21510 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S316088AbSG3Tu7>;
	Tue, 30 Jul 2002 15:50:59 -0400
Message-Id: <200207302057.PAA03624@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: async-io API registration for 2.5.29 
In-Reply-To: Your message of "Tue, 30 Jul 2002 14:31:46 -0400."
             <20020730143146.G10315@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Jul 2002 15:57:05 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bcrl@redhat.com said:
> Hmmm, it would be possible  to make the vsyscall page mapped by
> default and leave the global bit enabled  until UML forcibly unmapped
> it (and then clear the global bit and do a global  invalidate).  Would
> that be acceptible?

That sounds like it would work for me.

				Jeff

