Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVFOLoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVFOLoy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 07:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVFOLoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 07:44:54 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:14558 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S261400AbVFOLo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 07:44:27 -0400
Date: Wed, 15 Jun 2005 13:43:25 +0200
From: =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
To: Prarit Bhargava <prarit@sgi.com>
Cc: Steve Lord <lord@xfs.org>, "K.R. Foley" <kr@cybsft.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
Message-ID: <20050615114325.GG20567@ojjektum.uhulinux.hu>
References: <42AEDCFB.8080002@xfs.org> <42AEF979.2000207@cybsft.com> <42AF080A.1000307@xfs.org> <42AF0FA2.2050407@cybsft.com> <42AF165E.1020702@xfs.org> <42AF2088.3090605@sgi.com> <20050614205933.GC7082@ojjektum.uhulinux.hu> <42B010C0.90707@sgi.com> <20050615113423.GF20567@ojjektum.uhulinux.hu> <42B0127A.4000309@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42B0127A.4000309@sgi.com>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 07:35:22AM -0400, Prarit Bhargava wrote:
> Pozsár Balázs wrote:
> 
> >>If you're using bash, I would suggest starting with an update of the bash 
> >>package.
> >
> >
> >Well, I'm using 3.0 and afaik there's no newer version, but I don't 
> >think this is the problem either.
> >
> >Exactlywhat modifications have to be made and to what to work around 
> >this kernel regression?
> >
> 
> Just to be clear, this isn't a kernel regression -- it's a problem with 
> packages ;).

Let me this very clear: I've got a few initscripts written in bash, 
which load some modules.
These are very basic and trivial straightforward, basically some
"modprobe whatever".


All works fine with 2.6.9.
It does not work properly with 2.6.12-rc5.
This is a regression.



-- 
pozsy
