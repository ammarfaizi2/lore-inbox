Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313588AbSDQTvK>; Wed, 17 Apr 2002 15:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313589AbSDQTvJ>; Wed, 17 Apr 2002 15:51:09 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:1219 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313588AbSDQTvI>;
	Wed, 17 Apr 2002 15:51:08 -0400
Date: Wed, 17 Apr 2002 13:49:18 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Adam Kropelin <akropel1@rochester.rr.com>
cc: Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org,
        davej@suse.de, Brian Gerst <bgerst@didntduck.org>
Subject: Re: 2.5.8-dj1 : arch/i386/kernel/smpboot.c error
Message-ID: <1829430000.1019076558@flay>
In-Reply-To: <20020417191718.GA8660@www.kroptech.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I wonder if we can play the same trick we've played before ....
>> haven't tested the appended, but maybe it, or something like it
>> will work without the ifdef's?
> 
> IMHO, this sort of trickery in the name of improving readability
> is misguided. To me, anyway, the #ifdef's are much easer to read than
> magic name-changing macros buried in a header somewhere.

Well, except that you can take that abstraction inside your head, and
not worry about it when reading the mainline code. I don't really care
one way or the other, at least io.h is readable now ;-)

M.


