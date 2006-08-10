Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161136AbWHJIdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161136AbWHJIdW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 04:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161137AbWHJIdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 04:33:22 -0400
Received: from ns.firmix.at ([62.141.48.66]:16834 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1161136AbWHJIdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 04:33:21 -0400
Subject: Re: ext3 corruption
From: Bernd Petrovitsch <bernd@firmix.at>
To: Molle Bestefich <molle.bestefich@gmail.com>
Cc: Michael Loftis <mloftis@wgops.com>, linux-kernel@vger.kernel.org
In-Reply-To: <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
	 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
	 <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
	 <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
	 <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>
	 <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Thu, 10 Aug 2006 10:32:59 +0200
Message-Id: <1155198779.26431.7.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.374 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 20:28 +0200, Molle Bestefich wrote:
> Michael Loftis wrote:
> > > Is there no intelligent ordering of
> > > shutdown events in Linux at all?
> >
> > The kernel doesn't perform those, your distro's init scripts do that.
> 
> Right.  It's all just "Linux" to me ;-).

Then you are very probably questioning at the wrong place.

> (Maybe the kernel SHOULD coordinate it somehow,
>  seems like some of the distros are doing a pretty bad job as is.)

Patch your "Linux" to dump the output of "strace" of the init scripts
(it should be enough to improve the correct line in /etc/inittab) into a
log file and have fun considering the heuristics to be used in the
kernel to detect the dependencies.

AFAIK typical init scripts, the expression "extremely hard" is the
understatement of the year for this task.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

