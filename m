Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129361AbQLAVHQ>; Fri, 1 Dec 2000 16:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQLAVHG>; Fri, 1 Dec 2000 16:07:06 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:29122 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S129361AbQLAVGz>; Fri, 1 Dec 2000 16:06:55 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Arnaud Installe <ainstalle@filepool.com>
Cc: linux-kernel@vger.kernel.org
Date: Fri, 1 Dec 2000 13:20:03 -0800 (PST)
Subject: Re: high load & poor interactivity on fast thread creation
In-Reply-To: <20001201104745.C1413@bartok.filepool.com>
Message-ID: <Pine.LNX.4.21.0012011317280.18209-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have really good numbers for either, but I can say that I was
really impressed with this firewall yesterday. there were other problems
in the system that caused things to clog up, but a 2.4 AMD950 PC133 ram
system was useable (slow, but useable) with 4000+ processes and a loadave
of > 300

David Lang

 On Fri, 1 Dec 2000, Arnaud Installe wrote:

> Date: Fri, 1 Dec 2000 10:47:45 +0100
> From: Arnaud Installe <ainstalle@filepool.com>
> To: David Lang <david.lang@digitalinsight.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: high load & poor interactivity on fast thread creation
> 
> On Thu, Nov 30, 2000 at 03:00:10PM -0800, David Lang wrote:
> > try the 2.4 test kernels. I had a situation of poor performance with lots
> > of processes and saw a dramatic improvement with the 2.4 kernel.
> 
> So what load average should I expect Linux versions 2.2 and 2.4 to perform
> well under ?  I'm wondering what would be the best way to solve this
> problem: limit the number of processes created during a certain time span;
> check if the load average isn't too high before creating a new thread (and
> go to sleep if it isn't); or something else ?
> 
> Thanks very much BTW !  The list has always been very helpful.  :-)
> 
> 								Arnaud
> 
> > > When creating a lot of Java threads per second linux slows down to a
> > > crawl.  I don't think this happens on NT, probably because NT doesn't
> > > create new threads as fast as Linux does.
> > > 
> > > Is there a way (setting ?) to solve this problem ?  Rate-limit the number
> > > of threads created ?  The problem occurred on linux 2.2, IBM Java 1.1.8.
> 
> -- 
> Arnaud Installe						<ainstalle@filepool.com>
> 
> Man has never reconciled himself to the ten commandments.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
