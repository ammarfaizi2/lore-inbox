Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932659AbVIEJgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbVIEJgN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 05:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbVIEJgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 05:36:12 -0400
Received: from ns.firmix.at ([62.141.48.66]:11740 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932661AbVIEJgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 05:36:10 -0400
Subject: Re: forbid to strace a program
From: Bernd Petrovitsch <bernd@firmix.at>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <dfe7ui$14q$1@pD9F874C0.dip0.t-ipconnect.de>
References: <4IOGw-1DU-11@gated-at.bofh.it> <4IOGw-1DU-13@gated-at.bofh.it>
	 <4IOGw-1DU-9@gated-at.bofh.it> <4IOQc-1Pk-23@gated-at.bofh.it>
	 <dfe7ui$14q$1@pD9F874C0.dip0.t-ipconnect.de>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 05 Sep 2005 11:36:05 +0200
Message-Id: <1125912965.27110.34.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-09-04 at 09:32 +0200, Andreas Hartmann wrote:
> Chase Venters wrote:
[...]
> > 
> > Can I ask why you want to hide the database password from root?
> 
> It's easy: for security reasons. There could always be some bugs in some
> software, which makes it possible for some other user, to gain root
> privileges. Now, they could easily strace for information, they shouldn't

Forget it.
You cannot hide anything seriously from root (or equivalent users on
other OSes and so-called OSes) with such attempts (independent how the
process got root - with the correct password or through a security hole
somewhere).
Consider the case that root installed a (patched) DB-server which dumps
the passwords in some logfile. Or root logs from the authentication
framework (be it PAM or something else)

> could do it. The password they could see, isn't just used for the DB, but
> for some other applications, too. That's the disadvantage of general
> (single sign on) passwords.

So either you get your own machine or you use different passwords for
different services.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

