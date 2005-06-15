Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVFOLfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVFOLfA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 07:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVFOLe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 07:34:59 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:4573 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S261364AbVFOLea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 07:34:30 -0400
Date: Wed, 15 Jun 2005 13:34:23 +0200
From: =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
To: Prarit Bhargava <prarit@sgi.com>
Cc: Steve Lord <lord@xfs.org>, "K.R. Foley" <kr@cybsft.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
Message-ID: <20050615113423.GF20567@ojjektum.uhulinux.hu>
References: <42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org> <42AEDCFB.8080002@xfs.org> <42AEF979.2000207@cybsft.com> <42AF080A.1000307@xfs.org> <42AF0FA2.2050407@cybsft.com> <42AF165E.1020702@xfs.org> <42AF2088.3090605@sgi.com> <20050614205933.GC7082@ojjektum.uhulinux.hu> <42B010C0.90707@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42B010C0.90707@sgi.com>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 07:28:00AM -0400, Prarit Bhargava wrote:
> Pozsár Balázs wrote:
> >On Tue, Jun 14, 2005 at 02:23:04PM -0400, Prarit Bhargava wrote:
> >
> >>The second fix, and again you must do this if you're developing 2.6.12, 
> >>is to *update the mkinitrd package* which has a new version of /bin/sh.
> >
> >
> >This sounds insane to me. I am using bash in my initrd, does this mean 
> >that every shell and whatever has to be updated? Exactly what 
> >modifications has to be made?
> >
> >
> 
> If you're using bash, I would suggest starting with an update of the bash 
> package.

Well, I'm using 3.0 and afaik there's no newer version, but I don't 
think this is the problem either.

Exactlywhat modifications have to be made and to what to work around 
this kernel regression?


-- 
pozsy
