Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbTFFXxK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 19:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbTFFXxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 19:53:09 -0400
Received: from almesberger.net ([63.105.73.239]:38410 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262382AbTFFXxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 19:53:05 -0400
Date: Fri, 6 Jun 2003 21:06:20 -0300
From: Werner Almesberger <wa@almesberger.net>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030606210620.G3232@almesberger.net>
References: <20030606122616.B3232@almesberger.net> <200306070000.h5700OsG002995@ginger.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306070000.h5700OsG002995@ginger.cmf.nrl.navy.mil>; from chas@cmf.nrl.navy.mil on Fri, Jun 06, 2003 at 07:58:35PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams wrote:
> ever hang up in the middle of a call?  ever want to hang up
> in the middle of a phone call?

Yes, exactly: if you want to remove the phone, this also
removes the call. In TCP/IP, this isn't the case. Your
TCP connections will survive route changes, interface
removals, etc.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
