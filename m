Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272865AbRIGWJC>; Fri, 7 Sep 2001 18:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272866AbRIGWIw>; Fri, 7 Sep 2001 18:08:52 -0400
Received: from nicol6.umkc.edu ([134.193.4.67]:22541 "EHLO nicol6.umkc.edu")
	by vger.kernel.org with ESMTP id <S272865AbRIGWIn>;
	Fri, 7 Sep 2001 18:08:43 -0400
Message-ID: <3B9943F3.612D467B@umkc.edu>
Date: Fri, 07 Sep 2001 17:02:27 -0500
From: "David L. Nicol" <nicold@umkc.edu>
Organization: UMKC Information Services Central Systems
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: automatic per-connection ECN disabling
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I like the promise of explicit notification of congestion, and
have enabled ECN on my computer.  However, I am always forgetting
it is on and getting paranoid before I remember it and turn it
off in order to communicate with a server behind a non-ECN firewall.

How difficult would it be, I wonder, to set the TCP stack to
attempt a non-ECN connection if the first SYN does not come back
in reasonable time?  That is, send the second (or third) initial
SYN without the ECN option?

In effect it would be a third ECN mode besides on and off: Auto.

And it would make a good default.




-- 
                                           David Nicol 816.235.1187
Insist on genuine Dead Horse brand bongo drums.
