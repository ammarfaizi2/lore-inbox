Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131140AbRACBRs>; Tue, 2 Jan 2001 20:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130347AbRACBRh>; Tue, 2 Jan 2001 20:17:37 -0500
Received: from austin.jhcloos.com ([206.224.83.202]:18952 "HELO
	austin.jhcloos.com") by vger.kernel.org with SMTP
	id <S130277AbRACBRV>; Tue, 2 Jan 2001 20:17:21 -0500
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Andre Hedrick <andre@linux-ide.org>,
        Hakan Lennestal <hakanl@cdt.luth.se>
Subject: Re: Chipsets, DVD-RAM, and timeouts....
In-Reply-To: <20010102191600.511DD4185@tuttifrutti.cdt.luth.se>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: Hakan Lennestal's message of "Tue, 02 Jan 2001 20:15:55 +0100"
Date: 02 Jan 2001 18:46:55 -0600
Message-ID: <m3snn1a2dc.fsf@austin.jhcloos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Hakan" == Hakan Lennestal <hakanl@cdt.luth.se> writes:

Hakan> Yes, the problem is the hpt366 (or the sw), not the IBM drives.
Hakan> The IBM drives seem to work well with udma3 on the hpt but not
Hakan> with udma4 or higher.

Is this specific to the 366?  My DTLAs on a 370 are working like a
charm at udma5.  I haven't run bonnie or DiskPerf on them, but hdparm
shows values that look right (~36MB/s for -t and ~136MB/s for -T).

Box is currently on 2.2.18 + ide-2.2.18-1209, but was also run on
a 2.4.0-test1n (11 IIRC) for a while w/ similar results.

-JimC
-- 
James H. Cloos, Jr.  <http://jhcloos.com/public_key>     1024D/ED7DAEA6 
<cloos@jhcloos.com>  E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
