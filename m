Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268664AbTBZIyv>; Wed, 26 Feb 2003 03:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268685AbTBZIyv>; Wed, 26 Feb 2003 03:54:51 -0500
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:29144 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S268664AbTBZIyu>; Wed, 26 Feb 2003 03:54:50 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH][COMPAT] make struct compat_iovec
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus <torvalds@transmeta.com>, LKML <linux-kernel@vger.kernel.org>,
       anton@samba.org, "David S. Miller" <davem@redhat.com>, ak@muc.de,
       davidm@hpl.hp.com, ralf@gnu.org, matthew@wil.cx
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF22F54E7C.90692833-ONC1256CD9.0030C408@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Wed, 26 Feb 2003 09:54:52 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 26/02/2003 09:56:06
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (by zero extension in general, but s390x is probably diferent).

Not really, the difference is that an address in ESA mode has 31 bits
and not 32 bits. The llgtr instructions sets the upper 33 bits to zero.

blue skies,
   Martin


