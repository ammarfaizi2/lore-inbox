Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbUJ0Q3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbUJ0Q3P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbUJ0Q1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:27:49 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:3506 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S262487AbUJ0QRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:17:47 -0400
Date: Wed, 27 Oct 2004 18:17:13 +0200 (CEST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@fb07-2go.math.uni-giessen.de
To: Andreas Klein <Andreas.C.Klein@physik.uni-wuerzburg.de>
Cc: Andi Kleen <ak@muc.de>, Andrew Walrond <andrew@walrond.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: solution Re: lost memory on a 4GB amd64
In-Reply-To: <Pine.LNX.4.58.0410271751330.3903@pluto.physik.uni-wuerzburg.de>
Message-Id: <Pine.LNX.4.58.0410271809090.10573@fb07-2go.math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
 <200409241315.42740.andrew@walrond.org> <Pine.LNX.4.58.0410221053390.17491@fb07-2go.math.uni-giessen.de>
 <200410221026.22531.andrew@walrond.org> <20041022182446.GA77384@muc.de>
 <Pine.LNX.4.58.0410231220400.17491@fb07-2go.math.uni-giessen.de>
 <20041023164902.GB52982@muc.de> <Pine.LNX.4.58.0410241133400.17491@fb07-2go.math.uni-giessen.de>
 <Pine.LNX.4.58.0410271704050.3903@pluto.physik.uni-wuerzburg.de>
 <Pine.LNX.4.58.0410271718050.10573@fb07-2go.math.uni-giessen.de>
 <Pine.LNX.4.58.0410271751330.3903@pluto.physik.uni-wuerzburg.de>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Andreas Klein (AK) wrote:

AK> > The next difference: 
AK> > You have the S2885 (thunder K8W) and S2875S (tiger K8W single processor) 
AK> > boards and I have a S2875 (tiger K8W double processor)
AK> 
AK> The boards are nearly identical (on-board lan is different, and your 
AK> memory-slots are connected to one CPU).

I don't think that LAN is of any importance for our problems. 

But I was told (see previous messages) that the fact that all memory slots
are connedted to one CPU makes a non-NUMA board of it (S2875).

AK> If all memory modules are installed for one CPU, I have your problems. 

I see.

AK> Additionaly there are some other problems that only occur, when the 
AK> modules are installed one pair for each CPU.

IIRC [I might be wrong], Andrew is running this board (S2885) with exactly
this memory configuration without problems.



c ya
        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain
