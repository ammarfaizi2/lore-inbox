Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbWAQOEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWAQOEZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWAQOEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:04:24 -0500
Received: from smtpout.mac.com ([17.250.248.70]:48581 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932498AbWAQOEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:04:23 -0500
In-Reply-To: <43CCD453.9070900@tls.msk.ru>
References: <20060117174531.27739.patches@notabene> <43CCA80B.4020603@tls.msk.ru> <20060117095019.GA27262@localhost.localdomain> <43CCD453.9070900@tls.msk.ru>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B6E0BCA1-5F60-431F-8A29-9B36D3A05413@mac.com>
Cc: sander@humilis.net, NeilBrown <neilb@suse.de>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
Date: Tue, 17 Jan 2006 09:03:43 -0500
To: Michael Tokarev <mjt@tls.msk.ru>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 17, 2006, at 06:26, Michael Tokarev wrote:
> This is about code complexity/bloat.  It's already complex enouth.  
> I rely on the stability of the linux softraid subsystem, and want  
> it to be reliable. Adding more features, especially non-trivial  
> ones, does not buy you bugfree raid subsystem, just the opposite:  
> it will have more chances to crash, to eat your data etc, and will  
> be harder in finding/fixing bugs.

What part of: "You will need to enable the experimental  
MD_RAID5_RESHAPE config option for this to work." isn't bvious?  If  
you don't want this feature, either don't turn on  
CONFIG_MD_RAID5_RESHAPE, or don't use the raid5 mdadm reshaping  
command.  This feature might be extremely useful for some people  
(including me on occasion), but I would not trust it even on my  
family's fileserver (let alone a corporate one) until it's been  
through several generations of testing and bugfixing.


Cheers,
Kyle Moffett

--
There is no way to make Linux robust with unreliable memory  
subsystems, sorry.  It would be like trying to make a human more  
robust with an unreliable O2 supply. Memory just has to work.
   -- Andi Kleen


