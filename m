Return-Path: <linux-kernel-owner+w=401wt.eu-S1751089AbXAVPew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbXAVPew (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbXAVPew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:34:52 -0500
Received: from chert.unet.maine.edu ([130.111.32.28]:55456 "EHLO
	chert.unet.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbXAVPev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:34:51 -0500
X-Greylist: delayed 2062 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jan 2007 10:34:51 EST
Message-ID: <45B4D0ED.7030500@maine.edu>
Date: Mon, 22 Jan 2007 09:57:49 -0500
From: Steve Cousins <steve.cousins@maine.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: kyle <kylewong@southa.com>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: change strip_cache_size freeze the whole raid
References: <001801c73e14$c3177170$28df0f3d@kylecea1512a3f> <Pine.LNX.4.64.0701220717200.30260@p34.internal.lan>
In-Reply-To: <Pine.LNX.4.64.0701220717200.30260@p34.internal.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-DCC-UniversityOfMaineSystem-Metrics: chert.unet.maine.edu 1003; Body=1
	Fuz1=1 Fuz2=1
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-From: steve.cousins@maine.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Justin Piszcz wrote:
> Yes, I noticed this bug too, if you change it too many times or change it 
> at the 'wrong' time, it hangs up when you echo numbr > 
> /proc/stripe_cache_size.
> 
> Basically don't run it more than once and don't run it at the 'wrong' time 
> and it works.  Not sure where the bug lies, but yeah I've seen that on 3 
> different machines!

Can you tell us when the "right" time is or maybe what the "wrong" time 
is?  Also, is this kernel specific?  Does it (increasing 
stripe_cache_size) work with RAID6 too?

Thanks,

Steve
-- 
______________________________________________________________________
  Steve Cousins, Ocean Modeling Group    Email: cousins@umit.maine.edu
  Marine Sciences, 452 Aubert Hall       http://rocky.umeoce.maine.edu
  Univ. of Maine, Orono, ME 04469        Phone: (207) 581-4302


