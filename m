Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbTCOVEq>; Sat, 15 Mar 2003 16:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261571AbTCOVEq>; Sat, 15 Mar 2003 16:04:46 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:39841 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261568AbTCOVEn>; Sat, 15 Mar 2003 16:04:43 -0500
Date: Sat, 15 Mar 2003 21:13:06 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][kconfig][i386] Fix help entry for processor type choice
Message-ID: <20030315221259.GA26890@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	linux-kernel@vger.kernel.org
References: <20030315204009.GB31875@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030315204009.GB31875@pasky.ji.cz>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15, 2003 at 09:40:09PM +0100, Petr Baudis wrote:

 >  	bool "486"
 >  	help
 > -	  Select this for a x486 processor, ether Intel or one of the
 > +	  Select this for an x486 processor, either Intel or one of the

This bit is broken. There is no x486 processor, it should be either
'i486', '80486' or just '486'. There's already a patch fixing up this
(and x586 x686 etc) in Alans 2.5-ac patchset.

		Dave
