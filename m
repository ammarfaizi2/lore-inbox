Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293684AbSCATuW>; Fri, 1 Mar 2002 14:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293682AbSCATuM>; Fri, 1 Mar 2002 14:50:12 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:8716 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S293672AbSCATt5>;
	Fri, 1 Mar 2002 14:49:57 -0500
From: Cort Dougan <cort@fsmlabs.com>
Date: Fri, 1 Mar 2002 12:49:07 -0700
To: Alexander Viro <viro@math.psu.edu>
Cc: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Val Henson <val@nmt.edu>,
        "Randy.Dunlap" <rddunlap@osdl.org>, Laurent <laurent@augias.org>,
        linux-kernel@vger.kernel.org
Subject: Re: read_proc issue
Message-ID: <20020301124907.H31407@host110.fsmlabs.com>
In-Reply-To: <20020301071410.GA11256@arthur.ubicom.tudelft.nl> <Pine.GSO.4.21.0203010245150.2886-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0203010245150.2886-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Mar 01, 2002 at 02:47:26AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, please kill it!  seq files are much better and don't give people as
much of a chance to do things the wrong way.  Fewer interfaces to /proc
would be vast improvement.

} Oh, for fsck sake...
} 
} We already have better mechanism.  Let ->proc_read() die, it's an ugly
} kludge, breeding overcomplicated code and buffer overflows.
} 
} -
} To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
} the body of a message to majordomo@vger.kernel.org
} More majordomo info at  http://vger.kernel.org/majordomo-info.html
} Please read the FAQ at  http://www.tux.org/lkml/
