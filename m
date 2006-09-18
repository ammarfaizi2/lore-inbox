Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751797AbWIRQCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWIRQCT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWIRQCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:02:19 -0400
Received: from web36601.mail.mud.yahoo.com ([209.191.85.18]:21940 "HELO
	web36601.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751797AbWIRQCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:02:18 -0400
Message-ID: <20060918160217.97076.qmail@web36601.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Mon, 18 Sep 2006 09:02:17 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part 3/4: introduce new capabilities
To: Joshua Brindle <method@gentoo.org>, David Madore <david.madore@ens.fr>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
In-Reply-To: <1158579966.8680.24.camel@twoface.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Joshua Brindle <method@gentoo.org> wrote:

> And that is just practical stuff, there are still
> problems with
> embedding policy into binaries all over the system
> in an entirely
> non-analyzable way, and this extends to all
> capabilities, not just the
> open() one.

Your assertion that directly associating
the capabilities with the binary cannot
be analysed is demonstrably incorrect,
reference Common Criteria validation
reports CCEVS-VR-02-0019 and CCEVS-VR-02-0020.
 
The first system I took through evaluation
(that is, independent 3rd party analysis) stored
security attributes in a file while the second
and third systems attached the attributes
directly (XFS). The 1st evaluation required
5 years, the 2nd 1 year. It is possible that
I just got a lot smarter with age, but I
ascribe a significant amount of the improvement
to the direct association of the attributes
to the file.



Casey Schaufler
casey@schaufler-ca.com
