Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291906AbSBAS36>; Fri, 1 Feb 2002 13:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291905AbSBAS3s>; Fri, 1 Feb 2002 13:29:48 -0500
Received: from mrelay1.cc.umr.edu ([131.151.1.120]:32144 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S291901AbSBAS3c> convert rfc822-to-8bit;
	Fri, 1 Feb 2002 13:29:32 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Artificially starving a process for CPU/Disk/etc?
Date: Fri, 1 Feb 2002 12:29:32 -0600
Message-ID: <A69C6C0DB9068F40AC122C194F9DBEF0AEBD@umr-mail1.umr.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Artificially starving a process for CPU/Disk/etc?
Thread-Index: AcGrTmjaHR0wPxXCEda/IgBQVgAgFQ==
From: "Neulinger, Nathan" <nneul@umr.edu>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a situation where I want to simulate a server process getting starved for cpu/paging to death/etc. I realize I could renice the process(s) and then create artificial loading on the machine, but is there any way to do this more effectively?

I.e. is there some hack I could use to tell a particular set of processes that they get like 0.05% of the cpu time, even during idle?

The idea is to simulate a server that has gone south, but still be able to do monitoring/debug/analysis on that server to see what happens. During this happening in a real situation, you'd be unable to monitor on the box, cause it would be close to dead.

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216
