Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136050AbREGJAW>; Mon, 7 May 2001 05:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136049AbREGJAM>; Mon, 7 May 2001 05:00:12 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:39431 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S132922AbREGI77>; Mon, 7 May 2001 04:59:59 -0400
Message-ID: <3AF663F1.E04D90CE@idb.hist.no>
Date: Mon, 07 May 2001 10:59:29 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre7 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Tobias Ringstrom <tori@tellus.mine.nu>
CC: linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.33.0105070823060.24073-100000@svea.tellus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Ringstrom wrote:
> 
> On Sun, 6 May 2001, David S. Miller wrote:
> > It is the most straightforward way to make a '1' or '0'
> > integer from the NULL state of a pointer.
> 
> But is it really specified in the C "standards" to be exctly zero or one,
> and not zero and non-zero?

!0 is 1.  !(anything else) is 0.  It is zero and one, not
zero and "non-zero".  So a !! construction gives zero if you have
zero, and one if you had anything else.  There's no doubt about it.
> 
> IMHO, the ?: construct is way more readable and reliable.

Thats your opinion.  There are many others.  Some don't like the
?: at all, for example.  And some like all valid C.

Helge Hafting
