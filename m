Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRAPPVV>; Tue, 16 Jan 2001 10:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129825AbRAPPVL>; Tue, 16 Jan 2001 10:21:11 -0500
Received: from mail.rd.ilan.net ([216.27.80.130]:42509 "EHLO mail.rd.ilan.net")
	by vger.kernel.org with ESMTP id <S129584AbRAPPVB>;
	Tue, 16 Jan 2001 10:21:01 -0500
Message-ID: <3A6466D0.6587C11A@holly-springs.nc.us>
Date: Tue, 16 Jan 2001 10:20:48 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "James H. Cloos Jr." <cloos@jhcloos.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <3A5E10F5.716F83B7@holly-springs.nc.us> <m3snmpgu8t.fsf@austin.jhcloos.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"James H. Cloos Jr." wrote:
> 
> Michael> Please read and comment! :)
> 
> There should be some discussion on what to do about filenames which
> contain colons in such a setup.  Moving a file w/ a colon from a fs
> which does not support named streams to one which does should DTRT;
> exactly what TRT is should be discussed.

It seems that if you move a file with a colon -- "file:colon" -- in the
name from Ext2 to "StreamFS," you would end up with a file named "file"
with a stream named "colon". When copying back, you would get
"file:colon" back.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
