Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129597AbQLAKTK>; Fri, 1 Dec 2000 05:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129604AbQLAKTA>; Fri, 1 Dec 2000 05:19:00 -0500
Received: from uu194-7-68-2.unknown.uunet.be ([194.7.68.2]:35837 "EHLO
	bartok.iverlek.kotnet.org") by vger.kernel.org with ESMTP
	id <S129597AbQLAKSk>; Fri, 1 Dec 2000 05:18:40 -0500
Date: Fri, 1 Dec 2000 10:47:45 +0100
From: Arnaud Installe <ainstalle@filepool.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: high load & poor interactivity on fast thread creation
Message-ID: <20001201104745.C1413@bartok.filepool.com>
In-Reply-To: <20001130081443.A8118@bach.iverlek.kotnet.org> <Pine.LNX.4.21.0011301459250.17363-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0011301459250.17363-100000@dlang.diginsite.com>; from david.lang@digitalinsight.com on Thu, Nov 30, 2000 at 03:00:10PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 03:00:10PM -0800, David Lang wrote:
> try the 2.4 test kernels. I had a situation of poor performance with lots
> of processes and saw a dramatic improvement with the 2.4 kernel.

So what load average should I expect Linux versions 2.2 and 2.4 to perform
well under ?  I'm wondering what would be the best way to solve this
problem: limit the number of processes created during a certain time span;
check if the load average isn't too high before creating a new thread (and
go to sleep if it isn't); or something else ?

Thanks very much BTW !  The list has always been very helpful.  :-)

								Arnaud

> > When creating a lot of Java threads per second linux slows down to a
> > crawl.  I don't think this happens on NT, probably because NT doesn't
> > create new threads as fast as Linux does.
> > 
> > Is there a way (setting ?) to solve this problem ?  Rate-limit the number
> > of threads created ?  The problem occurred on linux 2.2, IBM Java 1.1.8.

-- 
Arnaud Installe						<ainstalle@filepool.com>

Man has never reconciled himself to the ten commandments.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
