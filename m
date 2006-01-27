Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWA0TvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWA0TvI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 14:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWA0TvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 14:51:08 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:11019 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S932494AbWA0TvH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 14:51:07 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <hyc@symas.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Date: Fri, 27 Jan 2006 11:50:41 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEHCJLAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <43D9D79D.9000402@symas.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 27 Jan 2006 11:47:29 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 27 Jan 2006 11:47:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If we just went with "whoever asks first" then clearly one of the
> blocked threads asked before the unlocker made its new request. You're
> arguing for my point, then.

	Huh? I am saying the policy can be anything at all. We could just go with
"whoever asks first", but we are not required to. And, in any event, I meant
whoever asks for the mutex first, not whoever blocks first. (Note that I
didn't say "whoever asked first" which would mean something totally
different.)

> Other ambiguities aside, one thing is clear - a decision is triggered by
> the unlock. What you seem to be arguing is the equivalent of saying that
> the decision is made based on the next lock operation.

	The spec says that the decision is triggered by a particular condition that
exists at the time of the unlock. That does not mean the decision is made at
the time of the unlock.

> The spec doesn't
> say that mutex_lock is to behave this way.

	We don't agree on what the specification says.

> Why do you suppose that is?

	Why do I suppose what? I find the specification perfectly clear and your
reading of it incredibly strained for the three reasons I stated.

> Perhaps you should raise this question with the Open Group.

	I don't think it's unclear.

	DS


