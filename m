Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265023AbTFRALQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 20:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbTFRALQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 20:11:16 -0400
Received: from mail.casabyte.com ([209.63.254.226]:42502 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S265023AbTFRALN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 20:11:13 -0400
From: "Robert White" <rwhite@casabyte.com>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       "Christoph Hellwig" <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
       "Brian Jackson" <brian@mdrx.com>,
       "Mark Hahn" <hahn@physics.mcmaster.ca>
Subject: RE: [PATCH] make cramfs look less hostile
Date: Tue, 17 Jun 2003 17:24:52 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGMECMDAAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20030615181424.GJ1063@wohnheim.fh-wedel.de>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "cut to the quick" version is that the message should be changed to
something both useful and non threatening.  Something to make the message
stand out as informational.

how about:

"cramfs: info: device is not a cramfs filesystem: wrong magic"

Then add a note to the docs that says: this message means the system was
trying to see if this was a cramfs.  In the absence of a later message
saying something like "could not mount device" this message is harmless.

There is then the "no-duh" factor to at least club people over the head with
for not doing their research.

This, of course, would make more sense if every filesystem mount attempt had
a similar message as well as a "thingyfs: file system mounted" too.  Of
course that would be ugly.

Since that isn't going to happen, stick to the simple human engineering
solution and make the message scream "info" duck the terseness... 8-)

Rob.

