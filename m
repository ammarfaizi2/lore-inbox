Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262748AbVBYQ46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbVBYQ46 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 11:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVBYQ44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 11:56:56 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:36879 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262748AbVBYQzf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 11:55:35 -0500
Date: Fri, 25 Feb 2005 17:55:50 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.8.1 to linux-2.6.10: Kernel Patching Issues.
Message-ID: <20050225165550.GA766@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10502251550520.26208-100000@mtfhpc.demon.co.uk> <1109350044.9681.26.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109350044.9681.26.camel@krustophenia.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 11:47:23AM -0500, Lee Revell wrote:
> On Fri, 2005-02-25 at 16:40 +0000, Mark Fortescue wrote:
> > The kernel patch files patch-2.6.9 and patch-2.6.10 do not apear to be
> > correct.
> 
> No, you're doing it wrong.  2.6.8.1 was a bugfix release.  The correct
> patching order is 2.6.8 -> 2.6.9 -> 2.6.10. 

 Hi did patch from 2.6.8:
#v+
3) bzcat ../patch-2.6.8.1.bz2 | patch -R -p1
        This gives a 2.6.8 kernel.
#v-

-- 
Tomasz Torcz               "Never underestimate the bandwidth of a station
zdzichu@irc.-nie.spam-.pl    wagon filled with backup tapes." -- Jim Gray

