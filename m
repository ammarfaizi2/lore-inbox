Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWDZT0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWDZT0U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 15:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWDZT0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 15:26:20 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:15365 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1750821AbWDZT0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 15:26:19 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: C++ pushback
Date: Wed, 26 Apr 2006 12:25:19 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 26 Apr 2006 12:21:20 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 26 Apr 2006 12:21:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 	As for remembering new names, that's a load of complete crap and I
> > find it hard to believe that you're raising the argument for honest
> > reasons.

> The scale of the kernel, the number and churn of developers, and the
> importance of not breaking things in a stable kernel tend to argue
> against you.  Humans develop the kernel.  Humans remember names well.
> You may think that's arbitrary, but when you change naming across the
> entire kernel, you confuse a very large and diverse group of people who
> do this because they enjoy it.  It's hard enough when this has to happen
> for useful or necessary reasons; you're asking the kernel developers to
> accept it for a completely arbitrary whim that they have rejected
> successfully several times in the past.

	C++ has how many additional reserved words? I believe the list is delete,
friend, private, protected, public, template, throw, try, and catch.
Renaming every symbol that currently has a name from this list to the
corresponding name with a trailing underscore is an easily understood
consistent change.

	That you would argue against is with things like "not breaking things" is a
load of complete crap.

> You want C++?  Fork the freely
> available source code at a convenient point and convert it yourself.  As
> long as it stays GPL, you're perfectly within your rights so to do.
> Hobson's choice is yours.  Belaboring this point is silly.

	Making ridiculous arguments like that a consistent change of a small set of
names is "breaking things in a stable kernel" is silly.

	And, FWIW, it isn't even necessary to change those names. That is only
needed to compile the kernel in C++, which is not what anyone was talking
about. Supporting C++ modules, for example, would work fine even if the
kernel had variables called 'class' or 'private'. (Though things could be
done a lot more cleanly if it didn't as it would require some remapping
before and after compilation.)

	DS


