Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272163AbTGYPyp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 11:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272164AbTGYPyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 11:54:45 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:5905 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S272163AbTGYPyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 11:54:44 -0400
Date: Fri, 25 Jul 2003 18:09:53 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: John Bradford <john@grabjohn.com>
Cc: ndiamond@wta.att.ne.jp, cs@tequila.co.jp, linux-kernel@vger.kernel.org
Subject: Re: Japanese keyboards broken in 2.6
Message-ID: <20030725160953.GD606@win.tue.nl>
References: <200307251601.h6PG1etD001373@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307251601.h6PG1etD001373@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 05:01:40PM +0100, John Bradford wrote:

> > One aspect of the matter is that raw mode no longer is raw.
> > The keyboard sends codes and the input layer translates that into
> > the codes the input layer thinks the keyboard should have sent.
> > Then, when one wants the raw codes, a reverse translation is used,
> > but since the mapping is not one-to-one the reverse translation
> > does not produce what the keyboard sent to start with.
> 
> Doesn't AT-set3 usually have a closer one to one mapping of keys?

Sorry - I am unable to make sense of your question.

Below some remarks, maybe related.

Some remarks on scancode sets live on
http://www.win.tue.nl/~aeb/linux/kbd/scancodes-7.html

Not all keyboards support all scancode sets. For example,
my MyCom laptop only supports scancode Set 2, and its keyboard
does not react at all when in mode 1 or 3. 

The normal, default mode is translated scancode set 2.
Putting keyboards in other modes is asking for trouble.

Andries

