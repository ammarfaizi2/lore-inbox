Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTKCGWK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 01:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTKCGWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 01:22:10 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:4351 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S261928AbTKCGWI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 01:22:08 -0500
Date: Mon, 3 Nov 2003 08:22:04 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: getrlimit for an arbitrary process?
Message-ID: <20031103062203.GT4640@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
References: <20031102090505.GB9015@niksula.cs.hut.fi> <Pine.LNX.4.44.0311022213140.28000-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311022213140.28000-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 02, 2003 at 10:14:11PM -0500, you [Rik van Riel] wrote:
> 
> Nope, rlimits only work on the current process
> (and a few of them work on the current UID).

Yep.
 
> > Couldn't find it under /proc, at least on 2.4.x.
> 
> Good idea for 2.7, though we might as well go
> all the way and set up more arbitrary resource
> groups.
> 
> Take a look at http://ckrm.sourceforge.net/  ;)

Interesting. So is linux-vservers (and a bunch of other projects). I hope
the common denominator of these can be distilled out and soaked into the
mainline kernel...


thanks,

-- v --

v@iki.fi
