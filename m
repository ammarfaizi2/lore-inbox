Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbTARMz2>; Sat, 18 Jan 2003 07:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbTARMz1>; Sat, 18 Jan 2003 07:55:27 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:384 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S264699AbTARMz1>; Sat, 18 Jan 2003 07:55:27 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "'Tomas Szepe'" <szepe@pinerecords.com>,
       "'Rob Wilkens'" <robw@optonline.net>
Cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: any chance of 2.6.0-test*?
Date: Sat, 18 Jan 2003 14:04:09 +0100
Message-ID: <002101c2bef2$17497b90$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20030112195347.GJ3515@louise.pinerecords.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Am I wrong that the above would do the same thing without generating the
> sphagetti code that a goto would give you.  Gotos are BAD, very very
> bad.
TS> Whom do I pay to have this annoying clueless asshole shot?
TS> OH MY GOD, I really can't take any more.

Well well well, is that how we act these days if we see something we don't
like?

Anyway, I totally agree with Rob: if the code can be written without a goto
and produce the same efficient assembly (or better, see Robs change) it
should be written without it.
goto's are for lazy people
