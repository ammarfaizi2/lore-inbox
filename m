Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275379AbTHITpC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 15:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275388AbTHITpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 15:45:01 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:49796 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275379AbTHITo7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 15:44:59 -0400
Date: Sat, 9 Aug 2003 20:44:57 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Chip Salzenberg <chip@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NULL.  Again.  (was Re: [PATCH] 2.4.22pre10: {,un}likely_p())
Message-ID: <20030809194457.GB30204@mail.jlokier.co.uk>
References: <1060087479.796.50.camel@cube> <20030809002117.GB26375@mail.jlokier.co.uk> <20030809081346.GC29616@alpha.home.local> <20030809015142.56190015.davem@redhat.com> <1060425774.4933.73.camel@dhcp22.swansea.linux.org.uk> <20030809162332.GB29647@mail.jlokier.co.uk> <20030809173001.GG24349@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030809173001.GG24349@perlsupport.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chip Salzenberg wrote:
> According to Jamie Lokier:
> > Not just K&R.  These are different because of varargs:
> > 	printf ("%p", NULL);
> > 	printf ("%p", 0);
> 
> *SIGH*  I thought incorrect folk wisdom about NULL and zero and pointer
> conversions had long since died out.  More fool I.  Please, *please*,
> _no_one_else_ argue about NULL/zero/false etc. until after reading this:
> 
>   ===[[  http://www.eskimo.com/~scs/C-faq/s5.html  ]]===

Thanks Chip; I am much enlightened.  That is a fine URL.

To onlookers: neither of those printf statements is portable :)

-- Jamie

