Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289243AbSA3PSG>; Wed, 30 Jan 2002 10:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289251AbSA3PR6>; Wed, 30 Jan 2002 10:17:58 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:9963 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289243AbSA3PRr>;
	Wed, 30 Jan 2002 10:17:47 -0500
Date: Wed, 30 Jan 2002 20:51:15 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Fw: Writeup on AIO design (uploaded) - corrected url
Message-ID: <20020130205115.B1864@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oops, oops, oops, I mispelt the website.
It should have been:

http://lse.sourceforge.net/io/aionotes.txt

My apologies !

(Thanks to Daniel Phillips and John Williams for pointing this out)

Regards
Suparna

----- Forwarded message from Suparna Bhattacharya <suparna@in.ibm.com> -----

Date: 	Wed, 30 Jan 2002 20:13:04 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Benjamin LaHaise <bcrl@redhat.com>, ak@suse.de, viro@math.psu.edu,
   jgmyers@netscape.com
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
   lse-tech@lists.sourceforge.net
Subject: Writeup on AIO design (uploaded)
Reply-To: suparna@in.ibm.com

Hello,

I have just uploaded the aio design notes to:
 http://lse.sourcefourge.net/io/aionotes.txt

Thanks to all those who helped with inputs and reviews of the interim 
drafts.

The writeup attempts to bring out some of the interesting design issues 
and discuss the solutions to those issues and the approach taken in 
Ben's design, and touches on the ideas for addressing some of the pending 
issues, todo items and potential enhancements. It also looks at some of
these aspects in the context of other implementations that exist or have 
been attempted on Linux (SGI kaio, Univ of Winsconsin-Madison's BAIO, 
Andi Kleen's early prototype), and the AIO related interfaces available 
on other OS's (POSIX aio, NT IOCPs, BSD kqueues), and also the DAFS api 
specifications. 

This was written with the intention of triggering discussions (though
this writeup wouldn't have been possible without all the discusions we've
already had :)). 

So please do share your insights, perspectives and comments. 

All the more so, if you already have a good understanding the aio 
design ! 

For those who are new to aio:
The focus here is only the in-kernel aio design, so you won't find much 
about actually using aio (Dan Kegel's page might be a better
place to start on that). There should, however, be some insights,
and pointers to the in-kernel primitives introduced as part of aio,
say, if you intend to implement your own async state machine (for some 
reason !). However, the writeup does not get into low level details and 
is not intended to be a substitute for looking at the code :). 
It should help you follow the code more easily though (I hope).

Regards
Suparna

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/

----- End forwarded message -----
