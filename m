Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTIUMpj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 08:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTIUMpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 08:45:39 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:45578 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262385AbTIUMpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 08:45:38 -0400
Date: Sun, 21 Sep 2003 14:45:36 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: John Bradford <john@grabjohn.com>
Cc: ndiamond@wta.att.ne.jp, vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5 vs. Japanese keyboards
Message-ID: <20030921144536.B11315@pclin040.win.tue.nl>
References: <200309211200.h8LC05jM000122@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200309211200.h8LC05jM000122@81-2-122-30.bradfords.org.uk>; from john@grabjohn.com on Sun, Sep 21, 2003 at 01:00:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 01:00:05PM +0100, John Bradford wrote:
> > > Exception 2:  a shifted 0 doesn't really produce a ~ but it is enough that a
> > > shifted ^ does so, but it doesn't matter that Linux has added real input for
> > > a shifted 0.)
> 
> This is wrong for some keyboards.
> 
> ~ is indeed shifted 0 on my keyboard - shifted ^ is an overbar.
> 
> Also, on my keyboard, - has a U.K. pound symbol as the fourth
> character on the key, (the top-right character).

This discussion is superfluous.
Keyboards differ - there is no way the kernel can guess at
the key label given the scancode.
That is why keymaps exist.
So, if Norman and John have keyboards with different behaviour
that just means that they must load different keymaps.

Andries

