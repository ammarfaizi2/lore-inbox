Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLOWJD>; Fri, 15 Dec 2000 17:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQLOWIn>; Fri, 15 Dec 2000 17:08:43 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:60526 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129228AbQLOWIf>; Fri, 15 Dec 2000 17:08:35 -0500
From: "LA Walsh" <law@sgi.com>
To: "Werner Almesberger" <Werner.Almesberger@epfl.ch>
Cc: "lkml" <linux-kernel@vger.kernel.org>
Subject: RE: Linus's include file strategy redux
Date: Fri, 15 Dec 2000 13:36:41 -0800
Message-ID: <NBBBJGOOMDFADJDGDCPHKENMCJAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20001215222117.S573@almesberger.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Werner Almesberger [mailto:Werner.Almesberger@epfl.ch]
> Sent: Friday, December 15, 2000 1:21 PM
> I don't think restructuring the headers in this way would cause
> a long period of instability. The main problem seems to be to
> decide what is officially private and what isn't.
---
	If someone wants to restructure headers, that's fine.  I was only
trying to understand the confusingly stated intentions of Linus.  I 
was attempting to fit into those intentions, not change the world.  

> > 	Any other solution, as I see it, would break existing module code.
> 
> Hmm, I think what I've outlined above wouldn't break more code than
> your approach. Obviously, modiles currently using "private" interfaces
> are in trouble either way.
---
	You've misunderstood.  My approach would break *nothing*.  

	If module-public include file includes a private, it would still
work since 'sys' would be a directory under 'include/linux'.  No new
links need be added, needed or referenced.  Thus nothing breaks.

-l
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
