Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUGGDAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUGGDAb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 23:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUGGDAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 23:00:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14317 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264857AbUGGDAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 23:00:30 -0400
Date: Wed, 7 Jul 2004 04:00:29 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: tom st denis <tomstdenis@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
Message-ID: <20040707030029.GD12308@parcelfarce.linux.theplanet.co.uk>
References: <20040706215622.GA9505@havoc.gtf.org> <20040707000612.39528.qmail@web41112.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707000612.39528.qmail@web41112.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 05:06:12PM -0700, tom st denis wrote:
> --- David Eger <eger@havoc.gtf.org> wrote:
> > Is there a reason to add the 'L' to such a 32-bit constant like this?
> > There doesn't seem a great rhyme to it in the headers...
> 
> IIRC it should have the L [probably UL instead] since numerical
> constants are of type ``int'' by default.  
> 
> Normally this isn't a problem since int == long on most platforms that
> run Linux.  However, by the standard 0xdeadbeef is not a valid unsigned
> long constant.

... and that would be your F for C101.  Suggested remedial reading before
you take the test again: any textbook on C, section describing integer
constants; alternatively, you can look it up in any revision of C standard.
Pay attention to difference in the set of acceptable types for decimal
and heaxdecimal constants.
