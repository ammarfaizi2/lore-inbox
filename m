Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbTFGArI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbTFGArH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:47:07 -0400
Received: from almesberger.net ([63.105.73.239]:54282 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262431AbTFGAqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:46:36 -0400
Date: Fri, 6 Jun 2003 21:59:42 -0300
From: Werner Almesberger <wa@almesberger.net>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: Mitchell Blank Jr <mitch@sfgoth.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030606215942.K3232@almesberger.net>
References: <20030606201906.F3232@almesberger.net> <200306070046.h570kBsG003360@ginger.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306070046.h570kBsG003360@ginger.cmf.nrl.navy.mil>; from chas@cmf.nrl.navy.mil on Fri, Jun 06, 2003 at 08:44:22PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams wrote:
> we (in particualr ekinize) added point to multipoint signalling.
> its mostly handled in user space (atmsigd).

Oh, that's pretty cool.

> at that point we would probably just fix it to use the netlink
> interface (or whatever is going to be the acceptable interface)

netlink is just the transport, plus a bit of addressing and such.
It's still largely up to you to decide what goes into these
messages.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
