Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbTBCBys>; Sun, 2 Feb 2003 20:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbTBCBys>; Sun, 2 Feb 2003 20:54:48 -0500
Received: from jaguar.mkp.net ([66.11.169.42]:3762 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id <S265608AbTBCByr>;
	Sun, 2 Feb 2003 20:54:47 -0500
To: Daniel Egger <degger@fhm.edu>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Compactflash cards dying?
From: "Martin K. Petersen" <mkp@mkp.net>
Organization: mkp.net
References: <20030202223009.GA344@elf.ucw.cz> <1044232591.545.8.camel@sonja>
Date: 02 Feb 2003 21:04:23 -0500
In-Reply-To: <1044232591.545.8.camel@sonja>
Message-ID: <yq1smv6qfvc.fsf@austin.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Daniel" == Daniel Egger <degger@fhm.edu> writes:

Daniel> CF has limited write cycles. A few hundred if you're lucky.

Aah, that's a bit pessimistic.  Even for a regular flash.

It is true that the number of write cycles varies between cards.  Some
vendors have both consumer and industrial grade cards, and the
industrial grade ones use better parts inside.

However, I have yet to see a CF card which didn't survive beyond a
million writes.

Note that CF cards do transparent wear averaging inside.  So it's
obviously not a million writes to the same physical spot.  Also, most
vendors claim they have spare blocks for relocating areas that are
completely worn out.

So while a Compact Flash isn't a hard disk, it is at least a couple of
orders of magnitude better than "hundreds of writes".

-- 
Martin K. Petersen	Wild Open Source, Inc.
mkp@wildopensource.com	http://www.wildopensource.com/


