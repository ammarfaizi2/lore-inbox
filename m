Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275692AbTHOHkN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 03:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275700AbTHOHkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 03:40:13 -0400
Received: from rth.ninka.net ([216.101.162.244]:25475 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S275692AbTHOHkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 03:40:10 -0400
Date: Fri, 15 Aug 2003 00:40:04 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: val@nmt.edu, daw@mozart.cs.berkeley.edu, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-Id: <20030815004004.52f94f9a.davem@redhat.com>
In-Reply-To: <20030815093003.A2784@pclin040.win.tue.nl>
References: <20030809173329.GU31810@waste.org>
	<20030813032038.GA1244@think>
	<20030813040614.GP31810@waste.org>
	<20030814165320.GA2839@speare5-1-14>
	<bhgoj9$9ab$1@abraham.cs.berkeley.edu>
	<20030815001713.GD5333@speare5-1-14>
	<20030815093003.A2784@pclin040.win.tue.nl>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Aug 2003 09:30:03 +0200
Andries Brouwer <aebr@win.tue.nl> wrote:

> On Thu, Aug 14, 2003 at 06:17:13PM -0600, Val Henson wrote:
> 
> > entropy(x) >= entropy(x xor y)
> > entropy(y) >= entropy(x xor y)
> 
> Is this trolling? Are you serious?

These lemma are absolutely true.  XOR is the worst way
to gain entropy because it means that if you are able
to know anything about either 'x' or 'y' then you are
able to know something about the resulting entropy.

It is the reason our ipv4 routing cache hashes used to
be exploitable.

