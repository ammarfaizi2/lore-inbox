Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVJHMu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVJHMu6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 08:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVJHMu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 08:50:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31158 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932093AbVJHMu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 08:50:57 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17223.49311.723163.216415@segfault.boston.redhat.com>
Date: Sat, 8 Oct 2005 08:50:39 -0400
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: autofs4 looks up wrong path element when ghosting is enabled
In-Reply-To: <Pine.LNX.4.63.0510081341460.2069@donald.themaw.net>
References: <17200.23724.686149.394150@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0509210916040.26144@wombat.indigo.net.au>
	<17203.7543.949262.883138@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0509241644420.2069@donald.themaw.net>
	<17205.48192.180623.885538@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0509250918150.2191@donald.themaw.net>
	<17208.24786.729632.221157@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0510081341460.2069@donald.themaw.net>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: autofs4 looks up wrong path element when ghosting is enabled; Ian Kent <raven@themaw.net> adds:

raven> On Mon, 26 Sep 2005, Jeff Moyer wrote:
>> I put together a different patch, but I want to get your input on the
>> approach before I post it.  It requires both user-space and kernel-space
>> changes.
>> 
>> Basically, you identify that a given automount tree is a direct map
>> tree.  This information is passed along to the kernel (I did this via a
>> mount option), and recorded (in the super block info).  Then, when a
>> directory lookup occurs, if we are in a direct map tree, and ghosting is
>> enabled, then we pass the lookup on to the real lookup code.
>> 
>> I'm not sold on the approach, as I haven't thought through all of the
>> implications.  Care to comment?

raven> Can you post your patch please Jeff.

I would, if it worked!  I'm away until the 17th.  I'll see what I can
come up with when I get back.  Sorry!

-Jeff
