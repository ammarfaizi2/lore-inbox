Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264819AbUGGBcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264819AbUGGBcR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 21:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUGGBcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 21:32:17 -0400
Received: from mailer2.psc.edu ([128.182.66.106]:21704 "EHLO mailer2.psc.edu")
	by vger.kernel.org with ESMTP id S264782AbUGGBcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 21:32:15 -0400
Date: Tue, 6 Jul 2004 21:32:09 -0400 (EDT)
From: John Heffner <jheffner@psc.edu>
To: "David S. Miller" <davem@redhat.com>
cc: <netdev@oss.sgi.com>, <linux-net@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix tcp_default_win_scale.
In-Reply-To: <20040706155013.32af8e13.davem@redhat.com>
Message-ID: <Pine.NEB.4.33.0407062130190.13672-100000@dexter.psc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2004, David S. Miller wrote:

> On Tue, 6 Jul 2004 17:55:12 -0400 (EDT)
> John Heffner <jheffner@psc.edu> wrote:
>
> > Another bit to addr to the firewall / window scale mess:  I remember from
> > a while ago that the Cisco PIX firewalls would not allow a window scale of
> > greater than 8.  I don't know if they've fixed this or not.  It seems
> > like some sort of arbitrary limit.
>
> In what manner did it deal with > 8 window scales?  By rewriting the option
> or deleting the option entirely from the SYN or SYN+ACK packets?

I don't recall.  It was not as ugly as changing the option value.  It may
have just sent a RST.

  -John

