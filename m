Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbTF1ABM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 20:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbTF1ABM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 20:01:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12218 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264953AbTF1ABH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 20:01:07 -0400
Date: Fri, 27 Jun 2003 17:09:07 -0700 (PDT)
Message-Id: <20030627.170907.71096768.davem@redhat.com>
To: mbligh@aracnet.com
Cc: greearb@candelatech.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1230000.1056754041@[10.10.2.4]>
References: <3EFC9203.3090508@candelatech.com>
	<20030627.144426.71096593.davem@redhat.com>
	<1230000.1056754041@[10.10.2.4]>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Martin J. Bligh" <mbligh@aracnet.com>
   Date: Fri, 27 Jun 2003 15:47:22 -0700

   --"David S. Miller" <davem@redhat.com> wrote (on Friday, June 27, 2003 14:44:26 -0700):
   
   > People DON'T understand.  I _WANT_ them to be able to
   > fall through the cracks.
   
   I fail to see your point here. If that's what you want, then just
   don't look at the bugme data.

bugme bugs persist, when I delete an email it doesn't get deleted
from the bugme database (at least when I go and view it).

Let me draw a diagram for you, say we have 3 contributors A B and
C.  They watch the mailing lists, analyze bugs, and work on new
features.  They work on what they want to, by the very nature of
open-source development.  When a bug hits a mailing list the
following might happen:

	A is overloaded, he deletes the email.
	B has a look, realizes he is not competent in this area
	and deletes the email.
	C analayzes and fixes the bug.

I want A and B to have never again have to deal with this bug
report.  There is zero point in having the capability to "delete"
the email if it persists in some database somewhere, it's not
deleted it's still in the backlog.

If nobody need fear their report get deleted by overload on
the developers, nobody need do anything but be lazy.  And that
system does not work, the contribution must be mutual for this
system to work.

This means that when developers are overloaded they can delete
your report and you'll resend it later.

I don't understand why people have no problem understanding that
this system works when it is in the context of lossy networking
protocols (IPV4) and the things that sit on top to ensure reliable
data delivery via retransmit (TCP), but when this idea is proposed
for things involving people and software development they fall to
fear and doubt.
