Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265814AbUFIRka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265814AbUFIRka (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 13:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265834AbUFIRka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 13:40:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:47053 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265814AbUFIRk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 13:40:29 -0400
Date: Wed, 9 Jun 2004 10:40:25 -0700
From: Chris Wright <chrisw@osdl.org>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       Chris Wright <chrisw@osdl.org>, Amon Ott <ao@rsbac.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dev@grsecurity.net
Subject: Re: security patches / lsm
Message-ID: <20040609104025.A21045@build.pdx.osdl.net>
References: <20040122191158.GA1207@schottelius.org> <20040122150937.A8720@osdlab.pdx.osdl.net> <20040609090346.GG601@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040609090346.GG601@schottelius.org>; from nico-kernel@schottelius.org on Wed, Jun 09, 2004 at 11:03:46AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nico Schottelius (nico-kernel@schottelius.org) wrote:
> Sorry for the late answer!
> 
> For me it looks like rsbac and grsecurity could get included in 2.6.
> 
> It looks like Amon did the work necessary to intergrate it into 2.6.
> (have a look at http://www.rsbac.org/).
> 
> And grsecurity also works nice with 2.6
> (http://www.grsecurity.net/download.php).
> 
> Who decides whether to integrate them or not?

Ultimately, that's Linus, often with some input from the rest of
the community.  Look, it's very simple.  Create patches, submit for
public review, update according to feedback, resubmit, etc.  The main
problem here is the patches above are invasive and considering where
we are in the 2.6 series (read: concerned utmost about stability) large
invasive patches aren't appropriate.  Further, there's an infrastructure
designed to support some of the features in the above patchsets, LSM.
And the idle complaints that it's inadequate without engaging in dialog
or supplying patches don't work very far towards a solution.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
