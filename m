Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbSIYBNJ>; Tue, 24 Sep 2002 21:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261873AbSIYBNJ>; Tue, 24 Sep 2002 21:13:09 -0400
Received: from holomorphy.com ([66.224.33.161]:23965 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261872AbSIYBNJ>;
	Tue, 24 Sep 2002 21:13:09 -0400
Date: Tue, 24 Sep 2002 18:17:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <dave@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.38-mm2 dbench $N times
Message-ID: <20020925011715.GG3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <dave@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <3D9103EB.FC13A744@digeo.com> <Pine.LNX.4.44.0209241802120.11685-100000@nighthawk.sr71.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209241802120.11685-100000@nighthawk.sr71.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Andrew Morton wrote:
>> dbench 16 on that sort of machine is a memory bandwidth test.
>> And a dcache lock exerciser.  It basically doesn't touch the
>> disk.  Something very bad is happening.
>> Anton can get 3000 MByte/sec ;)


On Tue, Sep 24, 2002 at 06:08:59PM -0700, Dave Hansen wrote:
> Bill's Machine cost around $50, plus the cost to repair the walls that I 
> crushed when hauling the pieces around.  Anton's cost $2 million.  Bill 
> wins :)
> Are you trying to bind the processes anywhere?  I wonder what would happen 
> if you make it always run quad 0...

It's probably more an artifact of not having substantial I/O subsystems.
This is basically a single-JBOD test.



Cheers,
Bill
