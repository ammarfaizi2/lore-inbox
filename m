Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263027AbUEBNFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbUEBNFe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 09:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbUEBNFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 09:05:34 -0400
Received: from tag.witbe.net ([81.88.96.48]:20996 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S263027AbUEBNFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 09:05:24 -0400
Message-Id: <200405021305.i42D5L625036@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Sean Estabrooks'" <seanlkml@rogers.com>,
       "'Marc Boucher'" <marc@linuxant.com>
Cc: <torvalds@osdl.org>, <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>, <riel@redhat.com>,
       <tconnors+linuxkernel1083378452@astro.swin.edu.au>,
       <mbligh@aracnet.com>, <nico@cam.org>
Subject: Re: [PATCH] clarify message and give support contact for non-GPL modules
Date: Sun, 2 May 2004 15:05:12 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040502084345.4b89d35f.seanlkml@rogers.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcQwQzyM/PUvMzYORQ6Wy0/coPQZeAAAg+Sg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm definitely no native English speaker, but I wanted to give my pov
on this topic...

> > Understood. So perhaps we should call it "open" and 
> "proprietary" which 
> > are clear, well known words. "tainted" is honestly 
> confusing/hard to 
> > understand for many ordinary users, especially 
> international/non-native 
> > speakers who do not encounter the word that often (thankfully ;-).
> 
> No.  It's tainted.  And hopefully if the user is concerned or 

Agreed. Once you have loaded such a module, your kernel is really
"tainted" by something that cannot really be controlled.
Proprietary is too much neutral and doesn't reflect what you are
now running : some piece of code which may by bloated without anyone
being able to control it.

> Linux is an open source operating system.  There is nothing wrong with
> promoting and protecting the code and license.
Correct.
 
> I've been looking at the latest version of the patch and 
> thinking that it is really
> wrong for any message to be displayed only once.   If the 
> user is unfortunate 
> enough to be loading two or more closed-source modules, the second
> module should not be hidden by the first.   The author of the 
> second module
> should not have their name hidden just because another module 
> was loaded first.

Agreed too.

This patch should make its way in the kernel, so that people are
aware they are using closed-source code.

I simply hope that some "vendors" will not alter kernel code before
building to remove such a warning if they include closed source
module in their distro.

Regards,
Paul

Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur

"Some people dream of success... while others wake up and work hard at it" 


