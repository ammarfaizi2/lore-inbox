Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbUBWN30 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 08:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUBWN3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 08:29:25 -0500
Received: from ns2.uk.superh.com ([193.128.105.170]:60612 "EHLO
	smtp.uk.superh.com") by vger.kernel.org with ESMTP id S261845AbUBWN3W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 08:29:22 -0500
Date: Mon, 23 Feb 2004 13:28:19 +0000
From: Richard Curnow <Richard.Curnow@superh.com>
To: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Jim Wilson <wilson@specifixinc.com>, Judith Lebzelter <judith@osdl.org>,
       Dan Kegel <dank@kegel.com>, cliff white <cliffw@osdl.org>,
       "Timothy D. Witham" <wookie@osdl.org>
Cc: Sean McGoogan <sean.mcgoogan@superh.com>
Subject: Re: Kernel Cross Compiling [update]
Message-ID: <20040223132819.GB16667@malvern.uk.w2k.superh.com>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	linux-kernel@vger.kernel.org, Jim Wilson <wilson@specifixinc.com>,
	Judith Lebzelter <judith@osdl.org>, Dan Kegel <dank@kegel.com>,
	cliff white <cliffw@osdl.org>,
	"Timothy D. Witham" <wookie@osdl.org>,
	Sean McGoogan <sean.mcgoogan@superh.com>
References: <20040222035350.GB31813@MAIL.13thfloor.at> <20040222155209.GA11162@linux-sh.org> <20040222170720.GA24703@MAIL.13thfloor.at> <20040222172307.GB11162@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222172307.GB11162@linux-sh.org>
User-Agent: Mutt/1.5.4i
X-OriginalArrivalTime: 23 Feb 2004 13:29:57.0718 (UTC) FILETIME=[21560760:01C3FA11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul Mundt <lethal@linux-sh.org> [2004-02-23]:
> > is there a toolchain/binutils which 'know' and 'support'
> > the '-isa=sh64' option? maybe it was depreciated?
> > 
> I don't know of one out in the wild. SuperH has their own toolchains that
> support this, and is what I currently use. I'm not sure what the status of
> their patches are in relation to getting merged into current gcc/binutils.
> Richard (CC'ed) might know though, Richard?

The last public release we made of the SH-5 tools is available at

    ftp://ftp.uk.superh.com/pub/SuperH-GNU/Barcelona-20030414

This URL provides further information:

    http://sourceforge.net/mailarchive/forum.php?thread_id=1984379&forum_id=9482

The SH-5 tools we're currently using in-house are a few months more
advanced than those.  (They date from about August 2003.)  We'd be happy
to package this version up and make it available if people express
interest in this.

BTW, if anyone who's using the 2003_04_14 release has found any
problems, please do let me know and I'll pass the information on to the
toolchain guys.

-- 
Richard \\\ SH-4/SH-5 Core & Debug Architect
Curnow  \\\         SuperH (UK) Ltd, Bristol
