Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282914AbSADSYs>; Fri, 4 Jan 2002 13:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288711AbSADSYi>; Fri, 4 Jan 2002 13:24:38 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:59364 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S282690AbSADSY3>; Fri, 4 Jan 2002 13:24:29 -0500
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
To: Andries.Brouwer@cwi.nl
Cc: acme@conectiva.com.br, adilger@turbolabs.com, ion@cs.columbia.edu,
        linux-fsdevel@vger.kernel.org, linux-fsdevel-owner@vger.kernel.org,
        linux-kernel@vger.kernel.org, phillips@bonn-fries.net
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF2FE44987.D9D207BC-ON87256B37.005AB446@boulder.ibm.com>
From: "Bryan Henderson" <hbryan@us.ibm.com>
Date: Fri, 4 Jan 2002 09:45:04 -0700
X-MIMETrack: Serialize by Router on D03NM031/03/M/IBM(Release 5.0.9 |November 16, 2001) at
 01/04/2002 09:45:05 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>    sizeof (foo): 1611, sizeof(foo): 19364 => -bs should be removed
>> ...
>>    int
>>    foo(int x): 11408, int foo(int x): 57275 => -psl should be removed
>
>I do not think good style is best defined by majority vote.

I don't think the implication was that sizeof(foo) is better style because
more people like it.  The implication is that consistency is, in general,
good programming style and it's easier to arrive at consistency by adhering
to the majority style than by adhering to the minority style.

Of course, there are other variables that may in any particular case have
more weight than the consistency or minimal effort considerations.

And I don't see what any of this has to do with whether an option should be
removed from Lindent.  Lindent should be a tool, which means it helps a
user do whatever he wants to do.  Whether he should want to do "sizeof
(foo)" is a separate issue.


