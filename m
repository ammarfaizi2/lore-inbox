Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbTFHDSS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 23:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbTFHDSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 23:18:18 -0400
Received: from almesberger.net ([63.105.73.239]:24845 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264412AbTFHDSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 23:18:17 -0400
Date: Sun, 8 Jun 2003 00:31:40 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "David S. Miller" <davem@redhat.com>
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030608003140.O3232@almesberger.net>
References: <20030606122616.B3232@almesberger.net> <200306070000.h5700OsG002995@ginger.cmf.nrl.navy.mil> <20030606210620.G3232@almesberger.net> <20030606.235340.85405522.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606.235340.85405522.davem@redhat.com>; from davem@redhat.com on Fri, Jun 06, 2003 at 11:53:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> But not a change in IP address :-)

Hmm yes, that might be a bit tricky to handle. Although one
could argue that a TCP connection could even exist through
this - you just couldn't send or receive traffic while the
local address isn't valid.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
