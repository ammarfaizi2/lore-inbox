Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269112AbUJTW7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269112AbUJTW7s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270434AbUJTWzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:55:35 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:4627 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S270436AbUJTWuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:50:13 -0400
Date: Wed, 20 Oct 2004 23:50:02 +0100
From: Dave Jones <davej@redhat.com>
To: John Cherry <cherry@osdl.org>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.9... (compile stats)
Message-ID: <20041020225002.GC12553@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	John Cherry <cherry@osdl.org>,
	Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <1098196575.4320.0.camel@cherrybomb.pdx.osdl.net> <20041019161834.GA23821@one-eyed-alien.net> <1098310286.3381.5.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098310286.3381.5.camel@cherrybomb.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 03:11:26PM -0700, John Cherry wrote:

 > Check out the complete details page
 > (http://developer.osdl.org/cherry/compile/).  Under "Warning/Error
 > Module Build Summaries", you can see how the warnings break down by
 > module.  For 2.6.9, they are...
 > 
 >    drivers/cpufreq: 2 warnings, 0 errors

false alarms like these (created by explicit #warnings) really
should be ignored IMO.  There's nothing to be fixed here.
At least, not yet.

		Dave

