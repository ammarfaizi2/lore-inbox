Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTFGBAz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 21:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbTFGBAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 21:00:55 -0400
Received: from almesberger.net ([63.105.73.239]:62218 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262482AbTFGA7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:59:19 -0400
Date: Fri, 6 Jun 2003 22:12:22 -0300
From: Werner Almesberger <wa@almesberger.net>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030606221222.M3232@almesberger.net>
References: <20030606212026.I3232@almesberger.net> <200306070053.h570rCsG003409@ginger.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306070053.h570rCsG003409@ginger.cmf.nrl.navy.mil>; from chas@cmf.nrl.navy.mil on Fri, Jun 06, 2003 at 08:51:23PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams wrote:
> but its actually pretty easy to do.  its similar to atmsigd
> exiting.  all the vcc's (on that device) would be purged and
> eventually close allowing the atm device to be removed from the kernel.

Ah, here you wrote it yourself. Yes, that would be a comprimise
that doesn't force you to make the removal itself asynchronous.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
