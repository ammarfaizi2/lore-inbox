Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbSKQXph>; Sun, 17 Nov 2002 18:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbSKQXph>; Sun, 17 Nov 2002 18:45:37 -0500
Received: from ns.suse.de ([213.95.15.193]:33802 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261646AbSKQXpg>;
	Sun, 17 Nov 2002 18:45:36 -0500
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: lan based kgdb
References: <1037490849.24843.11.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel> <20021116193008.C25741@work.bitmover.com.suse.lists.linux.kernel> <m11y5k3ruw.fsf@frodo.biederman.org.suse.lists.linux.kernel> <200211180725.27450.bhards@bigpond.net.au.suse.lists.linux.kernel> <m1smxz3mw7.fsf@frodo.biederman.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 18 Nov 2002 00:52:36 +0100
In-Reply-To: ebiederm@xmission.com's message of "17 Nov 2002 22:33:07 +0100"
Message-ID: <p73k7jbvjnf.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> I agree that you cannot do a perfect job.  The goal is to get something
> that is good enough so that it can be enabled and not give an automatic root
> exploit if someone accidentally leaves it on at the wrong time.

You can always use a simple mac / shared secret scheme. Just use HMAC on each 
packet. The kernel has all the needed code in crypto/ now.

May not be military grade, but should be good enough to stop most attacks.

-Andi
