Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272484AbTHOHzJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 03:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275694AbTHOHzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 03:55:09 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:59661 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S272484AbTHOHzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 03:55:04 -0400
Date: Fri, 15 Aug 2003 09:55:03 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, val@nmt.edu, daw@mozart.cs.berkeley.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030815095503.C2784@pclin040.win.tue.nl>
References: <20030809173329.GU31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030814165320.GA2839@speare5-1-14> <bhgoj9$9ab$1@abraham.cs.berkeley.edu> <20030815001713.GD5333@speare5-1-14> <20030815093003.A2784@pclin040.win.tue.nl> <20030815004004.52f94f9a.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030815004004.52f94f9a.davem@redhat.com>; from davem@redhat.com on Fri, Aug 15, 2003 at 12:40:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 12:40:04AM -0700, David S. Miller wrote:
> Andries Brouwer <aebr@win.tue.nl> wrote:
> 
> > On Thu, Aug 14, 2003 at 06:17:13PM -0600, Val Henson wrote:
> > 
> > > entropy(x) >= entropy(x xor y)
> > > entropy(y) >= entropy(x xor y)
> > 
> > Is this trolling? Are you serious?
> 
> These lemma are absolutely true.

David, did you read this line:

> > Try to put z = x xor y and apply your insight to the strings x and z.

Let us do it. Let z be an abbreviation for x xor y.

The lemma that you believe in, applied to x and z, says

 entropy(x) >= entropy(x xor z)
 entropy(z) >= entropy(x xor z)

But x xor z equals y, so you believe for arbitrary strings x and y that

 entropy(x) >= entropy(y)
 entropy(x xor y) >= entropy(y).

This "lemma", formulated in this generality, is just plain nonsense.

Andries


 

