Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <154763-27300>; Sun, 14 Feb 1999 15:56:00 -0500
Received: by vger.rutgers.edu id <154567-27300>; Sun, 14 Feb 1999 15:54:44 -0500
Received: from mail.blox.se ([195.7.73.197]:63183 "EHLO lix.blox.se" ident: "IDENT-NONSENSE") by vger.rutgers.edu with ESMTP id <154624-27302>; Sun, 14 Feb 1999 15:51:56 -0500
From: Bjorn Ekwall <bj0rn@blox.se>
Message-Id: <199902142140.WAA06554@lix.blox.se>
Subject: New snapshot of modutils
To: linux-kernel@vger.rutgers.edu
Date: Sun, 14 Feb 1999 22:40:08 +0100 (CET)
Cc: rth@piglet.twiddle.net (Richard Hendersson), jack@solucorp.qc.ca (Jacques Gelinas)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux-kernel@vger.rutgers.edu

Hi all,

Richard Hendersson is extremely busy at the moment.
After talking to him, Richard and I have agreed that I will help with
creating an updated release of the module support utilities.

So, for a snapshot of the current state, please look at:
	<http://www.pi.se/blox/modutils/>
You will find the latest snapshot as "modutils-snap990214.tar.gz"

It is quite possible that the development will by accessible via cvs
very soon; I'll keep you posted.

Please note that the depmod and modprobe utilities are back to C++.
This is a result of a discussion in linux-kernel last week, and
this is the way it has to be, in consideration of all involved.

I have verified that the current snapshot compiles, at least, but I haven't
done anything like a full-scale testing.  For the future, your suggestions
for improvements and restructuring are definitely welcome.
Send your input to <bj0rn@blox.se> and I will start upgrading even faster...

Here is part of the TODO-file:
- Upgrade modprobe and depmod with things that happened since modutils-2.1.23
- Verify that the current patches didn't break too much...
- Prepare for merging modprobe with insmod (too much duplication right now)
- Cleaner handling of multiple invocations of insmod
- Collect and merge more patches


Cheers,

Björn Ekwall <bj0rn@blox.se>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
