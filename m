Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131483AbRAQBlw>; Tue, 16 Jan 2001 20:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130311AbRAQBlm>; Tue, 16 Jan 2001 20:41:42 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:50099 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S131483AbRAQBlj>; Tue, 16 Jan 2001 20:41:39 -0500
Message-ID: <012901c0803f$b5e62df0$8501a8c0@gromit>
From: "Michael Rothwell" <rothwell@holly-springs.nc.us>
To: "Peter Samuelson" <peter@cadcamlab.org>
Cc: "James H. Cloos Jr." <cloos@jhcloos.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3A5E10F5.716F83B7@holly-springs.nc.us> <m3snmpgu8t.fsf@austin.jhcloos.com> <3A6466D0.6587C11A@holly-springs.nc.us> <20010116182806.B6364@cadcamlab.org>
Subject: Re: named streams, extended attributes, and posix
Date: Tue, 16 Jan 2001 20:40:27 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What if you copy both 'filename' and 'filename:ext' onto the same fs?
> Do they get combined into one file?

ON Ext2, you get two files. On NTFS, you get one file, and a stream on that
file.

> Any semantics by which 'filename:stream' and 'filename' refer to the
> same file would be b0rken.  If instead you use 'filename/stream'

That does not allow streams on directories, otherwise I agree.

-M



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
