Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbVA0LRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbVA0LRg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 06:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVA0LQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 06:16:09 -0500
Received: from smtp3.poczta.onet.pl ([213.180.130.29]:56749 "EHLO
	smtp3.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S262579AbVA0LMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 06:12:21 -0500
From: Sebastian Piechocki <sebekpi@poczta.onet.pl>
Reply-To: sebekpi@poczta.onet.pl
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: i8042 access timings
Date: Thu, 27 Jan 2005 12:12:23 +0100
User-Agent: KMail/1.7.1
Cc: Jaco Kroon <jaco@kroon.co.za>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <200501260040.46288.sebekpi@poczta.onet.pl> <41F888CB.8090601@kroon.co.za> <20050127102507.GC2702@ucw.cz>
In-Reply-To: <20050127102507.GC2702@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501271212.24143.sebekpi@poczta.onet.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia czwartek, 27 stycznia 2005 11:25, Vojtech Pavlik napisa³:
> On Thu, Jan 27, 2005 at 08:23:07AM +0200, Jaco Kroon wrote:
> > Sebastian Piechocki wrote:
> > >As I said I'm sending you mails from kernel masters:)
> >
> > Thanks.
> >
> > >If you haven't such a problem, please send them your dmesg with
> > >i8042.debug and acpi=off.
> >
> > I made an alternative plan.  I applied a custom patch that gives me
> > far less output and prevents scrolling and gets what I hope is what
> > is required.
>
> ... could you just increase the timeout value to some insane amount?
> That should take care of the AUX_LOOP output getting back only after
> issuing the next command.

Increasing the timeout doesn't help. I've increased timout ten times and 
the result is the same.

-- 
Sebastian Piechocki
sebekpi@poczta.onet.pl
