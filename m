Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130471AbRDDSqE>; Wed, 4 Apr 2001 14:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130487AbRDDSpy>; Wed, 4 Apr 2001 14:45:54 -0400
Received: from eschelon.gamesquad.net ([216.115.239.45]:23557 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S130471AbRDDSpn>; Wed, 4 Apr 2001 14:45:43 -0400
From: "Vibol Hou" <vhou@khmer.cc>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: mysqld [3.2.23] hangs when key_buffer ~256MB on [2.4.2-ac28+]
Date: Wed, 4 Apr 2001 11:44:00 -0700
Message-ID: <NDBBKKONDOBLNCIOPCGHKELLFOAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I initially upgraded my kernel from 2.4.2-ac5 to 2.4.3 and the first thing I
noticed was that mysqld was stuck.  Killing it left it hanging in a D state.
Then I tried 2.4.2-ac28 (which I am using now), and the got the same result.

My key_buffer was set to 256MB, so I figured maybe it was something to do
with memory usage so I lowered that figured to 128MB and restarted the
system to clear the D state procs.  Everything works fine now.  2.4.2-ac5
did not have issues with the larger key_buffer.

Can anyone reproduce this problem?

--
Vibol Hou
KhmerConnection, http://khmer.cc
"Connecting Cambodian Minds, Art, and Culture"

