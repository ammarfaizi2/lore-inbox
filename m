Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWHOVtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWHOVtY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 17:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWHOVtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 17:49:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13987 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750738AbWHOVtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 17:49:23 -0400
Date: Tue, 15 Aug 2006 17:49:14 -0400
From: Bill Nottingham <notting@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Mitch Williams <mitch.a.williams@intel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: bonding: cannot remove certain named devices
Message-ID: <20060815214914.GA5307@nostromo.devel.redhat.com>
Mail-Followup-To: Stephen Hemminger <shemminger@osdl.org>,
	Mitch Williams <mitch.a.williams@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060815194856.GA3869@nostromo.devel.redhat.com> <Pine.CYG.4.58.0608151331220.3272@mawilli1-desk2.amr.corp.intel.com> <20060815204555.GB4434@nostromo.devel.redhat.com> <20060815140249.15472a82@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815140249.15472a82@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger (shemminger@osdl.org) said: 
> > They're certainly allowed, and the sysfs directory structure, files,
> > etc. handle it ok. Userspace tends to break in a variety of ways.
> > 
> > I believe the only invalid character in an interface name is '/'.
> > 
> 
> The names "." and ".." are also verboten.

Right. Well, I suspect they're verboten-because-some-code-breaks-making-the-directory.

> Names with : in them are for IP aliases.

That's certainly not enforced at the kernel level.

Bill
