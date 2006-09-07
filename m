Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbWIGALx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbWIGALx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 20:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbWIGALx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 20:11:53 -0400
Received: from web36607.mail.mud.yahoo.com ([209.191.85.24]:402 "HELO
	web36607.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161014AbWIGALw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 20:11:52 -0400
Message-ID: <20060907001151.48122.qmail@web36607.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Wed, 6 Sep 2006 17:11:51 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060906132623.GA15665@clipper.ens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Madore <david.madore@ens.fr> wrote:

> ... (one merely needs to do
> something about
> the new bunch of capabilities I've introduced, but
> it should be easy
> to hack something which makes sure no programs are
> surprised or
> broken).

You have not introduced new capabilities
so much as you've introduced a new layer of
policy, that being things that unprivileged
processes can do but that "underprivileged"
processes cannot. I personally think that
this would make a spiffy LSM, but I don't
buy it as an extension of the POSIX (draft)
capability mechanism. Why? Because the
capability mechanism deals with providing
controls over the abilty to violate the
traditional Unix security policy, as
implemented in Linux. Adding "negative"
privilege might not be a bad idea, but
it is outside the scope of capabilities
AND there is a mechanism (LSM) explicity
in place for adding such restrictions.



Casey Schaufler
casey@schaufler-ca.com
