Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbUAYTXQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 14:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbUAYTXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 14:23:16 -0500
Received: from mail.cyberus.ca ([209.197.145.21]:64221 "EHLO mail.cyberus.ca")
	by vger.kernel.org with ESMTP id S265203AbUAYTW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 14:22:58 -0500
Subject: Re: [RFC/PATCH] IMQ port to 2.6
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20040125164431.GA31548@louise.pinerecords.com>
References: <20040125152419.GA3208@penguin.localdomain>
	 <20040125164431.GA31548@louise.pinerecords.com>
Content-Type: text/plain
Organization: jamalopolis
Message-Id: <1075058539.1747.92.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Jan 2004 14:22:19 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There has been no real good reason as to why IMQ is needed to begin
with. It may be easy to use and has been highly publized (which is
always a dangerous thing in Linux).

Maybe lets take a step back and see how people use it. How and why do
you use IMQ? Is this because you couldnt use the ingress qdisc?
Note, the abstraction to begin with is in the wrong place - it sure is
an easy and nice looking hack. So is the current ingress qdisc, but we
are laying that to rest with TC extensions.

cheers,
jamal

On Sun, 2004-01-25 at 11:44, Tomas Szepe wrote:
> On Jan-25 2004, Sun, 16:24 +0100
> Marcel Sebek <sebek64@post.cz> wrote:
> 
> > I have ported IMQ driver from 2.4 to 2.6.2-rc1.
> > Original version was from http://trash.net/~kaber/imq/.
> > ...
> 
> It would definitely be nice to see IMQ merged at last.

