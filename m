Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288344AbSACWYD>; Thu, 3 Jan 2002 17:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288346AbSACWX6>; Thu, 3 Jan 2002 17:23:58 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:28166 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S288344AbSACWWy>;
	Thu, 3 Jan 2002 17:22:54 -0500
Date: Thu, 3 Jan 2002 15:17:20 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Who uses hdx=bswap or hdx=swapdata?
Message-ID: <20020103151720.E20821@ftsoj.fsmlabs.com>
In-Reply-To: <3C34D6FC.9090207@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C34D6FC.9090207@colorfullife.com>; from manfred@colorfullife.com on Thu, Jan 03, 2002 at 11:11:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It used to be necessary on the IBM 830 CDROM but I think those have fallen
into disrepair and have undergone many changes.  The 830's likely need that
still but probably can't boot for other reasons now, though.

} Is the hdx=bswap or hdx=swapdata option actually in use?
} When is it needed?
} The current implementation can cause data corruptions on SMP with PIO 
} transfers:
} It modifies the source buffer during disk writes, and these temporary
} modifications (within the irq handler) are visible with mmap on SMP.
} 
} Is it possible to remove the option entirely, or should it be fixed?
} 
} --
}     Manfred
} 
} -
} To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
} the body of a message to majordomo@vger.kernel.org
} More majordomo info at  http://vger.kernel.org/majordomo-info.html
} Please read the FAQ at  http://www.tux.org/lkml/
