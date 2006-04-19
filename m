Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWDSJDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWDSJDQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 05:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWDSJDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 05:03:16 -0400
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:58314
	"EHLO pcpool00.mathematik.uni-freiburg.de") by vger.kernel.org
	with ESMTP id S1750777AbWDSJDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 05:03:16 -0400
Date: Wed, 19 Apr 2006 11:03:15 +0200
From: "Bernhard R. Link" <brlink@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060419090315.GA13025@pcpool00.mathematik.uni-freiburg.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com> <1145386009.21723.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145386009.21723.27.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk> [060418 21:20]:
> Poor security systems lead to less security than no security because it
> lulls people into a false sense of security. Someone who knows their
> house is insecure doesn't keep valuable items in it. Someone who thinks
> their house is secure but it is not increases the risk not decreases it.
> 
> Doing good security is hard, and it does need to be from a "default
> deny" basis.

Too strict security can also lead to less security than no security at
all. This is especialy true if security of only a part is too strict.

If system config files are only readable by root (or some admin role),
people will work as root (or with that admin role) to read them,
instead of adding some new config-file-reading group/role.
If users are forbidden to log in remotely via ssh, they might run
outgoing ssh portforwarding some telnet-like protocol in. If you
restrict what can be run on the computers too much, people might try
to plug in their laptops. If you force the doors locked and give too
few people a key, they will start leaving the windows open.

Hochachtungsvoll,
	Bernhard R. Link
