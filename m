Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267738AbUHVXF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267738AbUHVXF7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 19:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267756AbUHVXF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 19:05:58 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:40435 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S267738AbUHVXFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 19:05:50 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Olivier Galibert'" <galibert@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Cursed Checksums
Date: Mon, 23 Aug 2004 02:05:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040822225833.GA5225@dspnet.fr.eu.org>
Thread-Index: AcSInByjncpdUBsoQ4WzwW+dHbdkFgACIlUg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <S267738AbUHVXFu/20040822230550Z+97@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is what I intend to do, yet could you paste a working source code for;

- sniff data from a chosen interface
- put the same data in the same interface's inbound socket

If I could find how to do this via low-level libraries, I think I could
write an applet to do the mangling.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Olivier Galibert
Sent: Monday, August 23, 2004 12:59 AM
To: linux-kernel@vger.kernel.org
Subject: Re: Cursed Checksums

Why don't you patch the checksum when you change the IP?  It's just a
not of the sum the 16-bit words so take the old one, not it, add the
two 16-bits differences, re-not it and write it back.

  OG.



