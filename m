Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318041AbSFSWnA>; Wed, 19 Jun 2002 18:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318042AbSFSWm7>; Wed, 19 Jun 2002 18:42:59 -0400
Received: from mail.viewcast.com ([66.21.70.195]:5603 "EHLO mail.viewcast.com")
	by vger.kernel.org with ESMTP id <S318041AbSFSWm5>;
	Wed, 19 Jun 2002 18:42:57 -0400
From: "Scott Tillman" <tillman@viewcast.com>
To: "Martin Dalecki" <dalecki@evision-ventures.com>,
       "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "Garet Cammer" <arcolin@arcoide.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Need IDE Taskfile Access
Date: Wed, 19 Jun 2002 18:43:57 -0400
Message-ID: <CBELJEJGBEIGHCIMEDHNCEPBCIAA.tillman@viewcast.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <3D1038CC.3090108@evision-ventures.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>You are wasting electons, the interface is gone and the API to the
> >>transport is wrecked.  I will need to compose a loadable module
> to renable
> >>the support.  Clearly 2.5/2.6 is not friendly with the needs of the
> >>industry and it will never be at this rate.
>
> If the "industry" asks - I'm responsive for certain.
> Unless not - I don't.

Well, I'm not "the industry" but I think I know of another need for these
capabilities as well.

I'm working with a group of people in an effort to get Linux running on the
XBox.  The XBox uses a set of security PIO commands to restrict access to
the IDE drive, requiring a 32 byte password to be delivered before sector
access is allowed.  As far as I can tell from my investigations and from
earlier discussions with Andre there is currently no way to issue this
command.  If I'm wrong in my estimation just let me know how, otherwise I
simply wish add my voice to the (albeit small) outcry for supporting the
entire ATA spec.

Another comment/question (related to XBox support):
As part of this effort the xbox-linux team has coded support for the XBox's
proprietary partitioning and it's new filesystem.  This code (and any
further kernel support code) has been developed for the 2.4.18 kernel, and
we have no desire to port it to 2.5.x unless there is some hope of it's
adoption.  Could I get an official decision on whether this code might be
adopted if made available to the 2.5.x kernel?

-Scott Tillman aka SpeedBump

PS: flames about why we are supporting the XBox (a design of the Evil
Empire) will be summarily ignored.  I can only point you to it's HDTV, NTSC,
PAL, and possibly VGA outputs, it's dvd/cd drive, and it's $199 USD price
tag.

