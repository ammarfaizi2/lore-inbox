Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbTIXHl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 03:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTIXHl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 03:41:29 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4224 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262059AbTIXHl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 03:41:28 -0400
Date: Wed, 24 Sep 2003 08:40:35 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309240740.h8O7eZNI000474@81-2-122-30.bradfords.org.uk>
To: wakko@animx.eu.org, willy@w.ods.org
Subject: Re: [OT] Re: ATTACK TO MY SYSTEM
Cc: efault@gmx.de, elenstev@mesatop.com, jamagallon@able.es,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm running my own mailserver and it's hard not to accept it.  I have
> > basically done checks in the from and to headers.  If it appears as a virus,
> > i lockout the smtp sender.  It's not permenant.  When the virus stops, i
> > unblock every one.
>
> I've noticed that they *ALL* have their From:, To:, and Subject: written in
> uppercase. So it's really easy to filter them out depending on the tools used.
> If a mail header either matches ^FROM:, ^TO: or ^SUBJECT: then it has high
> chances to be a spam/virus. I checked all my recent mails and a few months
> back in LKML and did not found anything except spam/viruses which match this.
> At least, we should be lucky that these virus writers don't fully respect
> protocols...

What protocols are you referring to?

RFC 822, section 3.4.7, makes clear that case is _not_ significant for
these field names.  RFC 2822 doesn't change this.

Just because no commonly used E-Mail application seems to generate
uppercase field names, how do you know something like a password
auto-responder script won't?

That may not be a concern for you, but please don't spread
mis-information to others.

John.
