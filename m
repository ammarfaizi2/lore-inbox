Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310480AbSCPRhN>; Sat, 16 Mar 2002 12:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310482AbSCPRhE>; Sat, 16 Mar 2002 12:37:04 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:15853 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S310480AbSCPRgx>; Sat, 16 Mar 2002 12:36:53 -0500
Date: Sat, 16 Mar 2002 09:37:00 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Anton Blanchard <anton@samba.org>, lse-tech@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] 7.52 second kernel compile
Message-ID: <730219199.1016271418@[10.10.2.3]>
In-Reply-To: <20020316061535.GA16653@krispykreme>
In-Reply-To: <20020316061535.GA16653@krispykreme>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think Im addicted. I need help!

Well, you're not going to get much competition, so maybe help
would be more in order ;-) ;-)

Are you still doing something like this?
# MAKE="make -j14" /usr/bin/time make -j14 bzImage

I tried setting the MAKE variable as well as doing the -j,
but it actually made kernel compile time slower - what difference
does it make on your machine? Can somebody clarify what this
actually does, as opposed to the -j on the command line?

BTW - the other tip that was in the big book of whizzy kernel
compiles was to set gcc to use -pipe ... you might want to try
that.

How much of that 7.52 seconds are you spending in the final
single-threaded link & compress phase?

Thanks,

M.


