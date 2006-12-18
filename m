Return-Path: <linux-kernel-owner+w=401wt.eu-S1753712AbWLRKDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbWLRKDc (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 05:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753713AbWLRKDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 05:03:32 -0500
Received: from fallbackmx02.syd.optusnet.com.au ([211.29.133.72]:52428 "EHLO
	fallbackmx02.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753706AbWLRKDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 05:03:31 -0500
X-Greylist: delayed 26314 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 05:03:30 EST
Message-ID: <45860058.10904@opensourcelaw.biz>
Date: Mon, 18 Dec 2006 13:43:36 +1100
From: Brendan Scott <brendan@opensourcelaw.biz>
Organization: Open Source Law
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: gregkh@suse.de
CC: corbet@lwn.net, akpm@osdl.org, mbligh@mbligh.org, medwards.linux@gmail.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's just that I'm so damn tired of this whole thing.  I'm tired of
> people thinking they have a right to violate my copyright all the time.
> I'm tired of people and companies somehow treating our license in ways
> that are blatantly wrong and feeling fine about it.  Because we are a
> loose band of a lot of individuals, and not a company or legal entity,
> it seems to give companies the chutzpah to feel that they can get away
> with violating our license.

Why don't you consider some intermediate position?  If the issue is that you don't want people infringing copyright, then don't load the module unless it's accompanied by a [text] file in a standard format which states that the module is not infringing.  

So the default would be that non-GPL modules would not be loaded, but that the non-load could be easily circumvented by someone with a legitimate non-GPL module.  That would mean truly non infringing modules could be loaded.  Moreover, anyone could still load an infringing module, but to do so would mean they would need to actively be either reckless or lying (even if all the fields are left blank) - which would not look very good when it was exposed.  It would also help educate those people who are bona fide, but ignorant of their obligations.  

The file could include (eg):
Module name: 
Version number:
License: 
I have read the statement on GPL binary modules and the kernel developers' views on GPL-infringement available from [address]: yes/no
I verify that I have reviewed the developer's statement above and honestly believe that this version of this module does not infringe copyright in the kernel when assessed in accordance with that statement.  I also verify that in making this verification I am, or am acting on behalf of, the author(s) and copyright owner(s) of this module : [name]
Date verified: [date]
Name of organisation: 
Contact email:


If you're interested, I'd be happy to help draft something more involved. 


Regards


Brendan  

-- 
Brendan Scott IT Law Open Source Law 
0414 339 227 http://www.opensourcelaw.biz
Liability limited by a scheme approved under Professional Standards Legislation
Open Source Law Weekly digest: oswald@opensourcelaw.biz

