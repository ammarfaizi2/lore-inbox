Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266493AbUGBHje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266493AbUGBHje (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 03:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266495AbUGBHje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 03:39:34 -0400
Received: from ltgp.iram.es ([150.214.224.138]:12928 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S266493AbUGBHjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 03:39:24 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 2 Jul 2004 09:37:06 +0200
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jamie Lokier <jamie@shareable.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Michael Kerrisk <michael.kerrisk@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Testing PROT_NONE and other protections, and a surprise
Message-ID: <20040702073706.GA10286@iram.es>
References: <20040630024434.GA25064@mail.shareable.org> <20040630033841.GC21066@holomorphy.com> <20040701032606.GA1564@mail.shareable.org> <00345FCC-CB11-11D8-947A-000393ACC76E@mac.com> <20040701041158.GE1564@mail.shareable.org> <736E7483-CB1B-11D8-947A-000393ACC76E@mac.com> <20040701123941.GC4187@mail.shareable.org> <F64265B6-CB6C-11D8-947A-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F64265B6-CB6C-11D8-947A-000393ACC76E@mac.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 10:43:05AM -0400, Kyle Moffett wrote:
> On Jul 01, 2004, at 08:39, Jamie Lokier wrote:
> >The error code is -1, aka. MAP_FAILED.
> Oops!  I guess I was just lucky that part didn't fail :-D  On the other 
> hand, it
> couldn't legally return 0 anyway, could it?  That would have been a 
> slightly
> more sensible error code, IMHO, anyway, but it probably came from some
> silly standard somewhere.

It can, but only if you explicitly ask for it (MAP_FIXED with 0 as an
address), and it is very useful for DOS emulators.
	
	Cheers,
	Gabriel
