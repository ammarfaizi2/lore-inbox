Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbVBCKYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVBCKYa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbVBCKY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:24:29 -0500
Received: from sd291.sivit.org ([194.146.225.122]:61836 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262232AbVBCKYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:24:14 -0500
Date: Thu, 3 Feb 2005 11:24:12 +0100
From: Stelian Pop <stelian@popies.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050203102410.GA29712@sd291.sivit.org>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	linux-kernel@vger.kernel.org
References: <20050202155403.GE3117@crusoe.alcove-fr> <ctrr8c$4ho$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ctrr8c$4ho$1@terminus.zytor.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 12:29:00AM +0000, H. Peter Anvin wrote:

> > And now a question to Larry and whoever else is involved in the
> > bkcvs mirror on kernel.org: what is the periodicity of the CVS
> > repository update ? 
> > 
> 
> Currently it's nightly.  Larry has offered to run it more often if
> someone can provide a dedicated fast machine to run it on.  (Larry: is
> it a matter of memory or of CPU or both?  If nothing else we should
> have the old kernel.org server, dual P3/1133 with 6 GB RAM, coming
> free soon.)

Incremental updates should not be that resource consuming... Having the
repository updated every a few hours would be nice...

> Please let me know if there is something that should be put on
> kernel.org; we can host repositories there of course.

Maybe we could put the converted SVN repository (together with the
conversion tool) on kernel.org, and let those who are interested just
mirror it (either with svm or rsync) instead of generating it on
their own machine (which takes several hours). 

Is somebody interested ?

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
