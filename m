Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWAaXOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWAaXOG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 18:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWAaXOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 18:14:06 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:5005 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751067AbWAaXOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 18:14:04 -0500
In-Reply-To: <9162B459-F175-4F3A-9F7B-849890A9FDC2@mac.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Al Boldi <a1426z@gawab.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [RFC] VM: I have a dream...
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFC6272927.0C1225DD-ON88257107.007E29C3-88257107.007FA24A@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Tue, 31 Jan 2006 15:14:00 -0800
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Release 7.0HF124 | January 12, 2006) at
 01/31/2006 18:14:02,
	Serialize complete at 01/31/2006 18:14:02
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>1) IF the ONLY reason this was not done before is that 64-bit archs 
>were hard to get, then you are right.
>
>2) IF there were OTHER reasons, then you are not correct.
>
>This is the argument.  You keep discussing how 64-bit archs were not 
>easily available before and are now, and I AGREE, but that is NOT 
>RELEVANT to the point he made. 

As I remember it, my argument was that single level storage was known and 
practical for 25 years and people did not flock to it, therefore they must 
not see it as useful.  So if 64 bit processors were not available enough 
during that time, that blows away my argument, because people might have 
liked the idea but just couldn't afford the necessary address width.  It 
doesn't matter if there were other reasons to shun the technology; all it 
takes is one.  And if 64 bit processors are more available today, that 
might tip the balance in favor of making the change away from multilevel 
storage.

But I don't really buy that 64 bit processors weren't available until 
recently.  I think they weren't produced in commodity fashion because 
people didn't have a need for them.  They saw what you can do with 128 bit 
addresses (i.e. single level storage) in the IBM I Series line, but 
weren't impressed.  People added lots of other new technology to the 
mainstream CPU lines, but not additional address bits.  Not until they 
wanted to address more than 4G of main memory at a time did they see any 
reason to make 64 bit processors in volume.

Ergo, I do think it was something bigger that made the industry stick with 
traditional multilevel storage all these years.

--
Bryan Henderson                     IBM Almaden Research Center
San Jose CA                         Filesystems



