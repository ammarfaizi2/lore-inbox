Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272703AbRHaO3V>; Fri, 31 Aug 2001 10:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272704AbRHaO3M>; Fri, 31 Aug 2001 10:29:12 -0400
Received: from mail.teraport.de ([195.143.8.72]:37512 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S272703AbRHaO24>;
	Fri, 31 Aug 2001 10:28:56 -0400
Message-ID: <3B8F9F25.202B132C@TeraPort.de>
Date: Fri, 31 Aug 2001 16:28:53 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: torvalds@transmeta.com
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 08/31/2001 04:29:08 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 08/31/2001 04:29:14 PM,
	Serialize complete at 08/31/2001 04:29:14 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: [IDEA+RFC] Possible solution for min()/max() war
> 
> From: Linus Torvalds (torvalds@transmeta.com)
> Date: Mon Aug 27 2001 - 23:59:41 EST
> 
> 
> There were a few alternatives that we looked at (or rather, David
> implemented, and I ended up rejecting due to various reasons), but they
> all boiled down to "how do we sanely generate min/max functions while at
> the same time forcing people to understand the types in question". Some
> of the intermediate patches had the type in the macro name, ie things
> like "min_uint()" and "min_slong()". The final version (ie the one in
> 2.4.9) was deemed to be the most flexible.
> 

 Reading the whole (entertaining) thread my question is: couldn't the
min/max change wait until 2.5? It seems to "break" some code and that
should not happen in a "stable" stream?

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
