Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265440AbTLSESC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 23:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265444AbTLSESC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 23:18:02 -0500
Received: from secure.comcen.com.au ([203.23.236.73]:35857 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S265440AbTLSER7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 23:17:59 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: Catching NForce2 lockup with NMI watchdog
Date: Fri, 19 Dec 2003 14:17:19 +1000
User-Agent: KMail/1.5.1
Cc: George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
References: <200312180414.17925.ross@datscreative.com.au> <200312181130.46881.ross@datscreative.com.au> <Pine.LNX.4.55.0312181525070.23601@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0312181525070.23601@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312191417.19842.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 December 2003 00:32, Maciej W. Rozycki wrote:
> On Thu, 18 Dec 2003, Ross Dickson wrote:
> 
> > I grabbed the manuals that google search found.  By the look of it what I had
> > covered P3 and earlier. Yours are more up to date and cover P4.
> 
>  Newer manuals sometimes lack details that are present in older ones.  If
> you want to have a thorough view of the APIC, you certainly want to have
> all four variations of processor manuals, i.e. the one for P4+, the one
> for PII+, the one for PPro and the one for Pentium.  Plus manuals for the
> I/O APIC, e.g. the one for the i82093AA and perhaps for ones embedded into
> various chipsets.  All of them are or used to be available online.  If you
> want to go back to the i82489DX, there is a datasheet and a programming
> manual for the part, which are IMO the most exhaustive descriptions,
> though the implementation differed a bit from newer ones (the chip was so
> far the most powerful implementation of the APIC).  These were
> unfortunately never available online.
> 

Point taken, I generally play embedded MPU where the codebase matches the 
specific hardware version and one set of docs suffice, although it is not
uncommon to rediscover an unpublished bug.

This one codebase for all hardware certainly is a lot more work!

Do you know if the Athlon apic programming docs are available or under NDA?
I do not even want to ask about the nvidia nforce2 chipset.

Regards
Ross.

> -- 
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
> 
> 
> 

