Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbTENNwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbTENNwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:52:12 -0400
Received: from ns.suse.de ([213.95.15.193]:1796 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262231AbTENNwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:52:06 -0400
Date: Wed, 14 May 2003 16:04:49 +0200
From: Dave Jones <davej@suse.de>
To: Thomas Horsten <thomas@horsten.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
       Michael Elizabeth Chastain <mec@shout.net>
Subject: Re: [PATCH] 2.5.69 Changes to Kconfig and i386 Makefile to include support for various K7 optimizations
Message-ID: <20030514160449.B28115@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Thomas Horsten <thomas@horsten.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Michael Elizabeth Chastain <mec@shout.net>
References: <200305071834.26789.thomas@horsten.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200305071834.26789.thomas@horsten.com>; from thomas@horsten.com on Wed, May 07, 2003 at 06:34:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 06:34:26PM +0100, Thomas Horsten wrote:

[ick, backlog]

 > I made this patch to support the various K7 model-specific
 > optimizations that the later GCC compilers can use.
 > 
 > Please have a look, and pass me any comments.

I don't think this is worth the extra complication. The potential wins
(if any) outweigh the confusion to users who might have no clue as to
what core they have.  Additionally, some gcc's got these options wrong.
The athlon4 option was completely wrong for a while for eg.

 > I also have the same patch for 2.4, if you are interested it's
 > available on my Linux page on http://www.infowares.com/linux

For 2.4, it's an even worse idea IMO.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
