Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267312AbSLEMqn>; Thu, 5 Dec 2002 07:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267313AbSLEMqn>; Thu, 5 Dec 2002 07:46:43 -0500
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:56749 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S267312AbSLEMqm>; Thu, 5 Dec 2002 07:46:42 -0500
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'Shane Helms'" <shanehelms@eircom.net>, "'Ed Vance'" <EdV@macrolink.com>,
       "'jeff millar'" <wa1hco@adelphia.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: is KERNEL developement finished, yet ???
Date: Thu, 5 Dec 2002 06:54:17 -0600
Message-ID: <000901c29c5d$6d194760$2e833841@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <200212051224.50317.shanehelms@eircom.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> if you're implying that we can start once
> again from bottom, and come up with something
> better that unix (which has been opensource,
> around for long while, tested and developed
> by many as well) I _HIGHLY_ doubt, and disagree.

Yes and no.

Unix (and Linux) developers are far too concerned with clinging to the
30-year-old outdated POSIX standard, which creates numerous problems when
trying to advance new features.  For example, the POSIX standard is the
reason we have the three-by-three secure permissions on files (three users:
owner, group, everyone; three permissions: read, write, execute) instead of
Access Control Lists (ACL's).

This is not a design flaw per say, but let's face it: Unix would be a lot
more secure (and more flexible in it's security) with ACL's.

Microsoft Windows has had ACL's since 1991 (Windows NT 3.5?); that was 11
years ago.  Linux is just now developing ACL's in some of the beta kernels.
(By "Linux" I mean the official Linux kernel as distributed by
www.kernel.org not these stupid add-on's and patches released by
third-parties)

> I doubt there be any such errors (mistakes) if ANY

I don't know of any mistakes per say, but if I had to do it over again,
there's about a thousands things I'd do differently (preference in design
choices, not mistakes) especially not to cling so religiously to POSIX
compliance.

