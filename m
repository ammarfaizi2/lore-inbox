Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTFGKz7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 06:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTFGKz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 06:55:59 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:24965 "EHLO god.stev.org")
	by vger.kernel.org with ESMTP id S263025AbTFGKzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 06:55:53 -0400
Date: Sat, 7 Jun 2003 12:19:40 +0100 (IST)
From: James Stevenson <james@stev.org>
To: chas williams <chas@cmf.nrl.navy.mil>
cc: Werner Almesberger <wa@almesberger.net>,
       "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2) 
In-Reply-To: <200306070047.h570lfsG003377@ginger.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.44.0306071214110.19033-100000@god.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jun 2003, chas williams wrote:

> In message <20030606210620.G3232@almesberger.net>,Werner Almesberger writes:
> >TCP connections will survive route changes, interface
> >removals, etc.
> 
> really?  if i remove my ethernet interface i expect all the
> connections to die.

Think of a latop with a normall ethernet card in it.
When you unplug the cable it wont disconnect all the tcp
connection on the interface so that you could re route everything though
a wireless card.



