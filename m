Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136428AbREINHQ>; Wed, 9 May 2001 09:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136400AbREINHJ>; Wed, 9 May 2001 09:07:09 -0400
Received: from midten.fast.no ([213.188.8.11]:1284 "EHLO midten.fast.no")
	by vger.kernel.org with ESMTP id <S136428AbREINGK>;
	Wed, 9 May 2001 09:06:10 -0400
Subject: O_DIRECT support important for high data volume applications
From: Michael Susag <Michael.Susag@fast.no>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution/0.10 (Preview Release)
Date: 09 May 2001 15:06:05 +0200
Message-Id: <989413566.20025.2.camel@mach>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When will we see O_DIRECT support included in
the Linux kernel?

We have now tested 2.4.4 with the o_direct-5 patch,
and it still works perfectly.

I sent an email about two weeks ago asking if the O_DIRECT 
patch by Andrea Archangeli would be included in 2.4.4.
2.4.4 has since been released, but only with the rawio 
patch, which Andrea considered as a bugfix patch. 

The O_DIRECT patch is in my view really important
for high data volume applications that do 
caching internally. The performance graph 
I posted earlier should be enough evidence.

If I remember correctly, Stephen Tweedie implemented 
O_DIRECT support already back in 1999. Why this 
implementation was not included, I do not know.

Linux would be lacking behind other OSs if not 
O_DIRECT support is added. All major commercial 
OSs have this capability.


-- 
Michael Susæg, M.Eng.             Mail:  Michael.Susag@fast.no
Software Engineer                 Web:   http://www.fast.no/
Fast Search & Transfer ASA        Phone: +47 21 60 12 27
P.O. Box 1677 Vika                Fax:   +47 21 60 12 01
NO-0120 Oslo, NORWAY              Mob:   +47 90 06 38 70

Try FAST Search: http://www.alltheweb.com/


