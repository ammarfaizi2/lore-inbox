Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWA0Osw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWA0Osw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 09:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWA0Osw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 09:48:52 -0500
Received: from smtpout.mac.com ([17.250.248.71]:49905 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751475AbWA0Osv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 09:48:51 -0500
In-Reply-To: <43DA2795.707@ti-wmc.nl>
References: <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com> <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <43D9F9F9.5060501@ti-wmc.nl> <20060127133939.GU27946@ftp.linux.org.uk> <43DA2795.707@ti-wmc.nl>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <38EFBA62-0B08-4AE3-9663-0CB7D30BF5FA@mac.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Marc Perkel <marc@perkel.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
Date: Fri, 27 Jan 2006 09:47:45 -0500
To: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 27, 2006, at 09:00, Simon Oosthoek wrote:
> really? if it was dual licensed (that's what I meant, perhaps the  
> "or" should be an "and"? ;-), v2 in the kernel and v3 (or any later  
> version, etc.), if the code is used outside of the kernel, it would  
> "fall back to" v3+ as soon as it's taken out of the kernel and used  
> in something else.

You cannot say "This code is GPLv2 only in the context of the  
kernel".  You may say "This code is licensed under GPLv2 or GPLv3".   
The reasoning behind this is as follows:  If I take a kernel tree,  
and apply a large patch that removes all of the code except for your  
driver, the result is perfectly legal to distribute under GPLv2  
(because I took a combined GPLv2 source, applied any modification I  
felt like (such as deleting everything except one of the drivers),  
and therefore get a GPLv2 source.

One thing I am not sure about: If you have a kernel which contains  
code licensed under GPLv2 only and code licensed under GPLv3 only,  
would it be redistributable at all?  If so, under what conditions/ 
terms?  IANAL, so take the following with a couple pounds of salt;  
since GPLv2 says something like "You cannot add any additional  
restrictions", and GPLv3 adds additional restrictions, it might be  
true that the composite is not legally redistributable even though  
the two individual parts are, no?

Cheers,
Kyle Moffett

--
They _will_ find opposing experts to say it isn't, if you push hard  
enough the wrong way.  Idiots with a PhD aren't hard to buy.
   -- Rob Landley



