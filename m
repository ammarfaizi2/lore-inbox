Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262751AbVAJXjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbVAJXjf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 18:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVAJXjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 18:39:16 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:38407 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S262755AbVAJXgJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 18:36:09 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [2.6 patch] remove SPF-using wbsd lists from MAINTAINERS
Date: Mon, 10 Jan 2005 15:36:01 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEOFAPAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Importance: Normal
In-Reply-To: <1105382033.12054.90.camel@localhost.localdomain>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Mon, 10 Jan 2005 15:12:01 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Mon, 10 Jan 2005 15:12:03 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Llu, 2005-01-10 at 18:43, Adrian Bunk wrote:
> > IMHO lists rejecting emails based on some non-standard extension don't
> > belong into MAINTAINERS.
>
> Find out why someone is publishing records saying your mail isnt valid
> instead of moaning here. If they are using SPF and you are not using any
> strange extensions its fine. You or your provider appears to be
> advertising that stusta.de doesn't use the mail relay you are using.

	From reading this thread, it's not clear to me which of two possible
situations we are in:

	1) The mail server is rejecting perfectly valid email based upon it
requiring SPF or some similar problem with that mail server.

	2) The mail server is rejecting email because SPF is misconfigured on the
other end.

	I agree that an email address should not be in maintainers if it rejects
email simply because a domain does not use SPF or correctly configures SPF
such that the email should not be rejected (for example, by correctly saying
that it cannot list all the possible sources of email from that domain).
However, it is perfectly valid for it to drop emails based upon SPF that
specifically says that the email is invalid, non-standard extension or not.

	If you choose to use the non-standard extension and specifically use it to
communicate that certain emails are invalid, you have no right to complain
that the emails you claimed were invalid are treated as such by others.

	DS


