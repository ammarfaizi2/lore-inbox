Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbTEGBys (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 21:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbTEGBys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 21:54:48 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:1810 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262019AbTEGByq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 21:54:46 -0400
Date: Tue, 6 May 2003 23:07:54 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       devenyga@mcmaster.ca, rml@tech9.net, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: PATCH: Replace current->state with set_current_state in 2.5.6 8
Message-ID: <20030507020753.GF27162@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Gerrit Huizenga <gh@us.ibm.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
	"Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
	devenyga@mcmaster.ca, rml@tech9.net, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <20030506182456.644b70d1.rddunlap@osdl.org> <E19DEFM-00022j-00@w-gerrit2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19DEFM-00022j-00@w-gerrit2>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 06, 2003 at 07:01:27PM -0700, Gerrit Huizenga escreveu:
> On Tue, 06 May 2003 18:24:56 PDT, "Randy.Dunlap" wrote:
> > 
> > On Tue, 6 May 2003 17:33:26 -0700  "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com> wrote:
> > 
> > | However, I'd suggest to post this into the Kernel Janitors mailing list and
> > | let one of the big guys there swipe it in.
> > | 
> > 
> > Yes, the KJ list has already seen this patch and commented on some version
> > of it.
>  
> > Then it needs some exposure, like living in -ac or -mm or -pick1,
> > or at least some testing (everyday usage) by a few people, with reports
> > from them.
> > 
> > And I don't really want to review a 176 KB patch (although I did already
> > look over most of it a few days ago).  Do people want to take portions
> > of it for review and then see about Alan merging it, e.g.?
> 
> Hmm.  Has anyone considered a "Kernel Janitor's" tree?  More specifically,
> a patch set, much like -ac or -mm, with the current cleanups so they
> can be tested, pulled, run through automated batch testing, etc.?

That is an interesting idea, I'll probably start one.

- Arnaldo
