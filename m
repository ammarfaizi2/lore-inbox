Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265987AbUAQEWN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 23:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265992AbUAQEWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 23:22:13 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:19625 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265987AbUAQEWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 23:22:11 -0500
Date: Sat, 17 Jan 2004 05:22:08 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6.1 and cdrecord on ATAPI bus
Message-ID: <20040117042208.GA8664@merlin.emma.line.org>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040117031925.GA26477@widomaker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117031925.GA26477@widomaker.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jan 2004, Charles Shannon Hendrix wrote:

> I'm now running kernel 2.6.1, and using cdrecord with ATAPI is
> problematic.

I don't find it is. It's rather cdrecord insisting on scanning buses
itself and bitching about direct device names...

> First problem is that cdrecord now must reload media often, runs slowly,
> and burns slowly.  Reading CD/RW disks burned under 2.6.x is much slower
> than those burned under kernel 2.4 (same version of cdrecord in all
> cases).

Interesting. I use dev=/dev/hdc and it works fine for me (Plextor 48X),
but then again, I'm also running the latest cdrecord alpha.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
