Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264943AbTARRAY>; Sat, 18 Jan 2003 12:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264939AbTARRAY>; Sat, 18 Jan 2003 12:00:24 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:972 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S264943AbTARRAU>; Sat, 18 Jan 2003 12:00:20 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "'John Bradford'" <john@grabjohn.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: reading from devices in RAW mode
Date: Sat, 18 Jan 2003 18:09:13 +0100
Message-ID: <004d01c2bf14$54099340$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <200301181615.h0IGFhUU001597@darkstar.example.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I thought that I could do that at least for floppy, not sure about
> > harddisk (RLL through ACSI interface).
> Well, you can probably do it with ST-506 interface hard disk, because
> the data that goes in to that is more or less directly fed from the
> head-amp, which is partly why it was so sensitive to cable length.

Those were the times :-)

> The closest you could probably get with any modern device would be
> "read sector foo, and return data even if ECC appears to have
> failed".

And that's exactly what I want!
(for the situations where the bad data starts, say, halfway the sector)

