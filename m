Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbTFGAny (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbTFGAny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:43:54 -0400
Received: from almesberger.net ([63.105.73.239]:52234 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262444AbTFGAn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:43:29 -0400
Date: Fri, 6 Jun 2003 21:56:24 -0300
From: Werner Almesberger <wa@almesberger.net>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030606215624.J3232@almesberger.net>
References: <20030606210620.G3232@almesberger.net> <200306070047.h570lfsG003377@ginger.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306070047.h570lfsG003377@ginger.cmf.nrl.navy.mil>; from chas@cmf.nrl.navy.mil on Fri, Jun 06, 2003 at 08:45:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams wrote:
> really?  if i remove my ethernet interface i expect all the
> connections to die.

They survive at least ifconfig down, then ifconfig up. I have
to do this often enough :-( I think there was a time (probably
long long ago), when downing the interface killed them
immediately.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
