Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272702AbRHaOSJ>; Fri, 31 Aug 2001 10:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272701AbRHaOSA>; Fri, 31 Aug 2001 10:18:00 -0400
Received: from cpe-24-221-114-147.az.sprintbbd.net ([24.221.114.147]:3981 "EHLO
	localhost.digitalaudioresources.org") by vger.kernel.org with ESMTP
	id <S272702AbRHaORr>; Fri, 31 Aug 2001 10:17:47 -0400
Message-ID: <3B8F9C90.7080100@digitalaudioresources.org>
Date: Fri, 31 Aug 2001 07:17:52 -0700
From: David Hollister <david@digitalaudioresources.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Chris Abbey <linux@cabbey.net>, linux-kernel@vger.kernel.org
Subject: Re: Athlon doesn't like Athlon optimisation?
In-Reply-To: <Pine.LNX.4.30.0108302117150.16904-100000@anime.net> <Pine.LNX.4.33.0108302353380.4964-100000@tweedle.cabbey.net> <3B8F4A64.8B9DEDE4@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> For the upcomming Red Hat Linux release an athlon kernel
> will be included, and due to the people who have this
> problem, I added a kernel commandline option to disable
> the optimized page_copy() and clear_page() functions.
> The use of this option makes the machines, of the people
> who had this problem, happy again.
> 
> Now I also wrote the 2 functions in question, and I am
> very convinced that they are correct. They also work on
> the vast majority of motherboards, and most of the failure
> cases are cheaper motherboards (or cheap PSU's).

Hey look, folks.  I didn't point a finger and try to blame anybody or anything. 
  I'm as much a Linux advocate as the next guy.  Granted, I have not tried every 
trick under the sun to get it to work.  I don't really care that much.  I can 
live with my memory accesses taking a few microseconds longer.  My point, and my 
only point, to all this was just to add data.  If there's something relatively 
easy I can try, I will.  Otherwise, life goes on.
-- 
David Hollister
Driversoft Engineering:  http://devicedrivers.com
Digital Audio Resources: http://digitalaudioresources.org

