Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274578AbRITRkq>; Thu, 20 Sep 2001 13:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274579AbRITRkg>; Thu, 20 Sep 2001 13:40:36 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:15387 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274578AbRITRkX>; Thu, 20 Sep 2001 13:40:23 -0400
Subject: Re: AGPGART for AMD 761 broken in 2.4.10-pre12?
From: Robert Love <rml@ufl.edu>
To: DevilKin@gmx.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010920172940.A93A89BB3F@pop3.telenet-ops.be>
In-Reply-To: <20010920171534.C26E09BB3F@pop3.telenet-ops.be> 
	<20010920172940.A93A89BB3F@pop3.telenet-ops.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.19.21.54 (Preview Release)
Date: 20 Sep 2001 13:40:47 -0400
Message-Id: <1001007650.6050.14.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-20 at 13:28, DevilKin wrote:
> I've manually applied the patch written for the pre-11 kernels, and then it 
> works great. Could it be it hasn't been added to pre-12?

It looks like my patch was unmerged in 2.4.10-pre12, as Linus merged the
AGP GART code from Alan's tree which does not yet have AMD 761 support. 
The patch for Alan is pending and hopefully will be in the next -ac.

Applying the 2.4.10-pre11 patch should half apply (the config entries
are still there, and some of the header code, but not the main detection
stuff), but that would work.

I am rediffing a patch (and some other minor cleanup) for 2.4.10-pre12
and I will send it to Linus.  I will CC you and the list.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

