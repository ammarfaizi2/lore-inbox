Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312680AbSDSQRS>; Fri, 19 Apr 2002 12:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312681AbSDSQRR>; Fri, 19 Apr 2002 12:17:17 -0400
Received: from ns.suse.de ([213.95.15.193]:25860 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312680AbSDSQRQ>;
	Fri, 19 Apr 2002 12:17:16 -0400
To: Tim Kay <timk@advfn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP: Treason uncloaked DoS ??
In-Reply-To: <200204191512.g3JFCvl18558@mail.advfn.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 Apr 2002 18:17:13 +0200
Message-ID: <p731ydbacja.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Kay <timk@advfn.com> writes:
> that the connections are kept open if the client connecting doesn't actually 
> go away so surely lots of these ocurring at once would overload a server. I 
> have googled this and an occasional instance seems normal and could be down 
> to a broken client, but lots from different IP addr's at once??

It is a TCP bug of the other side.

You can safely comment out the printk. It would be interesting however
to find out what the other side is running and yell at the vendor.

> I'm a bit concerned that maybe someone is warming up for a hit or something.

More likely someone released a new buggy TCP stack to the world.

-Andi
