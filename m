Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263521AbTI2PI3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTI2PI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:08:29 -0400
Received: from codepoet.org ([166.70.99.138]:38887 "EHLO mail.codepoet.org")
	by vger.kernel.org with ESMTP id S263521AbTI2PIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:08:25 -0400
Date: Mon, 29 Sep 2003 09:08:23 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Rob Landley <rob@landley.net>
Cc: public@mikl.as, linux-kernel@vger.kernel.org
Subject: Re: Linksys WRT54G: Part 2
Message-ID: <20030929150823.GA5160@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Rob Landley <rob@landley.net>, public@mikl.as,
	linux-kernel@vger.kernel.org
References: <200309281914.24869.public@mikl.as> <200309290103.17004.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309290103.17004.rob@landley.net>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Sep 29, 2003 at 01:03:16AM -0500, Rob Landley wrote:
> It's probable that Linksys itself didn't know this.  (They wouldn't go to the 
> trouble of creating a GPL Code Center to post knowingly incomplete code.)

Nope.  It is absolute certainty they know about it.  I had my
lawyer contact them months ago, and the cisco Legal department
was made aware of this and other problems, and responded that

    "the Linksys technical folks are digging into your questions -
    all the the software in question is from Linksys' suppliers
    (Linksys doesn't have the source code to this software), so we
    have to work with these suppliers to address any concerns."

but that was July 15 and I have heard nothing substantive from
them since that time.

> At every proprietary softare company I've ever worked for, and this sort of 
> knowledge was limited to one or two individual engineers, who often left the 
> project when it shipped.  The support guys often don't know diddly, and 
> management is seldom even aware how much there IS to know.
> 
> Keep the pressure up, but be nice and give them some time to audit their 
> codebase.  Firmware development was probably outsourced to india or taiwan or 
> something, and Linksys (nee Cisco) is quite possibly furious at whoever they 
> outsourced this to for putting them in this position in the first place...

How much niceness do they need?  I had my lawyer send the first
of several letters (nice and polite) on 8 May...  After several
additional letters (increasingly less polite) my lawyer and I
were finally contacted by Cisco on June 20.  They stated at that
time "We are in the process of determining what code is subject
to the distribution obligation; once we have done so, all such
code will be made available under the terms of the GPL."

On July 10 they informed us they were setting up their GPL Code
Center.  We informed them on that data that (at least) the
WRT55AG, and WAP54G products also contain Linux and need to have
the GPL'd sources published.  We also informed the Cisco legal
dept on July 10 that they have have not provided source code for
'libnetconf' (which staticly includes iptables/netfilter code),
and since they have shippied zillions of these things, they are
obligated to release source not just libnetconf, but also all
applications linked with libnetconf.

They have not yet addressed that issue despite 2.5 months passing
since their legal department was informed.  When combined with
the issue of the broken kernel they distribute, it is hard to
argue they have acted in good faith at complying.

> And there will be more in the future.  Proprietary software companies aren't 
> used to having _access_ to code without the obigations for using it already 
> having been discharged.  (Usually up-front cash payments, although sometimes 
> it's a percentage of revenues, and sometimes it's bartering for other code or 
> bundling deals or whatever.)
> 
> And even though many of them then go on and violate that license six ways from 
> sunday afterwards (by simply not caring in the rush to ship), they're not 
> used to being called on it afterwards.  Open source doesn't just do 
> distributed development and debugging better than the proprietary guys, we do 
> distributed license auditing. :)

Yes I know.  My dad (a lawyer) tries to help me with handling
these.  But it takes time and effort, and GPL violating products
are being released faster than I can mail letters.... 

> Query: should this kind of thing have its own mailing list?  There are a 
> number of organizations that might want to pool their resources on these 
> issues (off the top of my head, OSI, Linux International, and OSDL spring to 
> mind.  The FSF would also be a logical candidate, if logic applied to the 
> FSF, but the absence of ftp.gnu.org/pub/decss strongly implies it doesn't.)

Regarding Linksys, Bradley Kuhn of the FSF has worked with a
number of the Linksys violatees, starting in the middle of June.
We had a few conference calls and whatnot.  But I've not heard
from them since early July -- I expect other more pressing
concerns have taken precedence.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
