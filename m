Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317602AbSGJUUC>; Wed, 10 Jul 2002 16:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317603AbSGJUUB>; Wed, 10 Jul 2002 16:20:01 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:35211 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S317602AbSGJUT7>;
	Wed, 10 Jul 2002 16:19:59 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 10 Jul 2002 14:20:05 -0600
To: Robert Love <rml@tech9.net>
Cc: Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  July 10, 2002
Message-ID: <20020710142005.U762@host110.fsmlabs.com>
References: <3D2B89AC.25661.91896FEB@localhost> <1026323661.1178.73.camel@sinai> <20020710191824.GT1548@niksula.cs.hut.fi> <1026331418.1244.82.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1026331418.1244.82.camel@sinai>; from rml@tech9.net on Wed, Jul 10, 2002 at 01:03:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why was the rate incremented to maintain interactive performance?  Wasn't
that the whole idea of the pre-empt work?  Does the burden of pre-empt
actually require this?

It seems that the added inefficiency of these extra interrupts is going to
drag performance down.

} George Anzinger's 64-bit jiffies are in 2.5.
} 
} Tim's code to better utilize them is in 2.5 I _think_.
} 
} > Didn't Red Hat change HZ to 1000 (or 1024) in Limbo as well? How did they
} > handle that?
} 
} Yes, RedHat's current devel kernel is using HZ=1000.  I am not sure how
} they handled it.  What we have in 2.5 now is correct.
} 
} 	Robert Love
} 
} -
} To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
} the body of a message to majordomo@vger.kernel.org
} More majordomo info at  http://vger.kernel.org/majordomo-info.html
} Please read the FAQ at  http://www.tux.org/lkml/
