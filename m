Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTFJVXk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbTFJVWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:22:11 -0400
Received: from almesberger.net ([63.105.73.239]:45574 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264042AbTFJVUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 17:20:52 -0400
Date: Tue, 10 Jun 2003 18:34:09 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "David S. Miller" <davem@redhat.com>
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030610183409.R3232@almesberger.net>
References: <20030606125416.C3232@almesberger.net> <200306062354.h56NsWsG002919@ginger.cmf.nrl.navy.mil> <20030606212026.I3232@almesberger.net> <20030606.235811.39162108.davem@redhat.com> <20030608004540.P3232@almesberger.net> <1055054601.30054.4.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055054601.30054.4.camel@rth.ninka.net>; from davem@redhat.com on Sat, Jun 07, 2003 at 11:43:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Netdevices NO LONGER use module refcounts in any way shape or form. They
> are not needed to fix problems of this nature.

Oh, I see. I didn't notice that change, sorry. Indeed, that looks
quite promising.

Is this mature enough in 2.5.70 to make it worth looking for holes,
or should I rather wait a bit ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
