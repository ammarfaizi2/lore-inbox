Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319144AbSHFPFh>; Tue, 6 Aug 2002 11:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319145AbSHFPFh>; Tue, 6 Aug 2002 11:05:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:35770 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319144AbSHFPFh>;
	Tue, 6 Aug 2002 11:05:37 -0400
Date: Tue, 06 Aug 2002 08:06:12 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, colpatch@us.ibm.com
Subject: Re: [PATCH] NUMA-Q xquad_portio declaration
Message-ID: <1245189818.1028621171@[10.10.2.3]>
In-Reply-To: <1028649942.18130.172.camel@irongate.swansea.linux.org.uk>
References: <1028649942.18130.172.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> This patch is from Matt Dobson. It corrects the definition of
>> >> xquad_portio, getting rid of a compile warning.
>> > 
>> > Marcelo - I have a much cleaner change for this.
>> 
>> Can you publish it? ;-)
> 
> I did - its in -ac4 

The STANDALONE thing? I'm not convinced that's really any cleaner,
it makes even more of a mess of io.h than there was already (though
we could consider that a lost cause ;-)). 

What's your objection to just throwing in a defn of xquad_portio?
A preference for burying the messy stuff in header files? Seems to
me that as you have to define STANDALONE now, the point is moot.

M.

