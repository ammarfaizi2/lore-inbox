Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261762AbSJCQAw>; Thu, 3 Oct 2002 12:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261763AbSJCQAw>; Thu, 3 Oct 2002 12:00:52 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:18852 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261762AbSJCQAu>;
	Thu, 3 Oct 2002 12:00:50 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [Evms-devel] Re: EVMS Submission for 2.5
To: Christoph Hellwig <hch@infradead.org>
Cc: "Kevin M Corry" <corryk@us.ibm.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.4  June 8, 2000
Message-ID: <OF479E53F5.0433681B-ON85256C47.0057D3AF@pok.ibm.com>
From: "Steve Pratt" <slpratt@us.ibm.com>
Date: Thu, 3 Oct 2002 11:09:37 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/03/2002 12:05:17 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig wrote:

>> subdirectories were created: drivers/evms/ for the main source code,
>> and include/linux/evms/ for the header files.

>What's the reason to not have the headers under drivers/evms.

None, really. Why does md put it's headers in include/linux/raid ???
We can put them wherever.

> And why don'T you just use drivers-md like all other volume management
drivers?

Because it is getting crowded.  Why does every filesystem create it's own
directory in fs?  Maybe drivers/vm/md drivers/vm/dm drivers/vm/evms would
be better.  Again, we can put it wherever, this just seems like a logical
place.

Steve




