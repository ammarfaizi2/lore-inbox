Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTJRGlI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 02:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbTJRGlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 02:41:08 -0400
Received: from neors.cat.cc.md.us ([204.153.79.3]:44718 "EHLO
	student.ccbc.cc.md.us") by vger.kernel.org with ESMTP
	id S261376AbTJRGlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 02:41:06 -0400
Date: Sat, 18 Oct 2003 02:36:27 -0400 (EDT)
From: John R Moser <jmoser5@student.ccbc.cc.md.us>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6 freeze and grsecurity
Message-ID: <Pine.A32.3.91.1031018022547.30954A-100000@student.ccbc.cc.md.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I may have asked this before but I forget.

Is there any plan to impliment grsecurity into the final 2.6 release 
before all the tests are finished and the thing is frozen totally?  I 
think it's worth it.  I did notice seLinux, but as far as I understand 
it, grsecurity is different from seLinux.  As far as I understand, 
seLinux is a lower-than-os ACL system, whereas grsecurity is a security 
vulnerability squelcher; that is, seLinux lets you control who does what, 
whereas grsecurity tries to make sure that broken programs don't 
constitute a security hazzard and evade the system's security 
countermeasures.  That is my understanding of PaX, grsecurity, and 
seLinux in a nutshell.

Due to this "kill the problem at its source" approach to executable 
security bugs, I think that grsec belongs in 2.6's core distribution, if 
possible.  As far as I know, there is no 2.6 patch for grsecurity, but 
I'd at least feel better knowing that Linus (and the other guy, who's 
name escapes me right now) would at least consider allowing grsec to make 
its way to the core distribution of the kernel even if a 2.6 patch 
doesn't make it out until a few revisions in.  The generic security 
increase is something that nobody can really argue with, although other 
issues like the sudden strange inclusion of a whole new section in the 
kernel for a revision may provide the other side of the argument.

GRsec is in no way all-powerful, but I really feel safer with it.

--Bluefox Icy
