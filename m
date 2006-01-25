Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWAYXwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWAYXwm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 18:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWAYXwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 18:52:42 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:64699
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751241AbWAYXwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 18:52:41 -0500
Date: Wed, 25 Jan 2006 15:52:04 -0800
From: Greg KH <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: eranian@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] 2.6.16-rc1 perfmon2 patch for review
Message-ID: <20060125235204.GB21195@kroah.com>
References: <200601201520.k0KFKEm2023128@frankl.hpl.hp.com> <1137775645.28944.61.camel@serpentine.pathscale.com> <20060124150912.GB7130@frankl.hpl.hp.com> <1138219693.15295.13.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138219693.15295.13.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 12:08:13PM -0800, Bryan O'Sullivan wrote:
> On Tue, 2006-01-24 at 07:09 -0800, Stephane Eranian wrote:
> 
> > Because I tried regrouping all the /proc AND related interface into a single
> > C file.
> 
> sysctls seem to be every bit as deprecated as /proc for what you are
> tring to do.
> 
> > Well, it is not clear to me what criteria is used for /sys vs /proc.
> 
> My understanding is that only process-related stuff belongs in /proc
> now.  Other random cruft that has accumulated over the years is left
> there for backwards compatibility, but /sys interfaces are the way
> forward now.

Yes, that is exactly right.

thanks,

greg k-h
