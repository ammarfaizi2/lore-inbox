Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLRXZc>; Mon, 18 Dec 2000 18:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbQLRXZW>; Mon, 18 Dec 2000 18:25:22 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:43214 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S129391AbQLRXZL>; Mon, 18 Dec 2000 18:25:11 -0500
Message-ID: <3A3E95B3.19E51EEE@inet.com>
Date: Mon, 18 Dec 2000 16:54:43 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: generic sleeping locks?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow me to display my ignorance a moment.

Are there blocking lock primitives already defined somewhere in the
kernel?

It just seems that 

while( lockvar )
	sleep_on( &lockwaitq );

along with its various permutations would be commonly used and worthy of
being made into a generic sleep lock.  A few blind greps through the
source didn't find anything that caught my eye.

If there aren't, would a patch to add them be of interest to anyone? 
Input on design details welcome.

TIA,

Eli 
--------------------. "To the systems programmer, users and applications
Eli Carter          | serve only to provide a test load."
eli.carter@inet.com `---------------------------------- (random fortune)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
