Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbTHUU5B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 16:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbTHUU5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 16:57:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42978 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262906AbTHUU47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 16:56:59 -0400
Date: Thu, 21 Aug 2003 21:56:56 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, gkajmowi@tbaytel.net,
       linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: Initramfs
Message-ID: <20030821205656.GG454@parcelfarce.linux.theplanet.co.uk>
References: <200308210044.17876.gkajmowi@tbaytel.net> <1061447419.19503.20.camel@camp4.serpentine.com> <3F44D504.7060909@pobox.com> <1061490490.23060.9.camel@serpentine.internal.keyresearch.com> <20030821190358.GF454@parcelfarce.linux.theplanet.co.uk> <1061495854.23060.12.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061495854.23060.12.camel@serpentine.internal.keyresearch.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 12:57:34PM -0700, Bryan O'Sullivan wrote:
> On Thu, 2003-08-21 at 12:03, viro@parcelfarce.linux.theplanet.co.uk
> wrote:
> 
> > RTFM.  cpio -o -H newc should be used to create an archive; _not_ the
> > "binary" format that is default.
> 
> There is no FM to R in this regard.

Ouch.  My apologies - I'd assumed that it got into the tree and hadn't
checked that.  Google for "initramfs buffer spec" will give the text
I had in mind.  Probably ought to go in Documentation/*, unless hpa
has any problems with it.  Peter?
