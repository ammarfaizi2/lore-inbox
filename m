Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbVADWrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbVADWrB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVADWp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:45:28 -0500
Received: from bender.bawue.de ([193.7.176.20]:31946 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S262405AbVADWof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:44:35 -0500
Date: Tue, 4 Jan 2005 23:44:27 +0100
From: Joerg Sommrey <jo175@sommrey.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Oops on 2.6.9-ac16: xfs, dm and md may be involved
Message-ID: <20050104224427.GB9135@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo175@sommrey.de>,
	Nathan Scott <nathans@sgi.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20041221185754.GA28356@sommrey.de> <20041222182606.GA14733@infradead.org> <20041222195203.GA24857@sommrey.de> <20041223101143.A702917@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041223101143.A702917@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 10:11:43AM +1100, Nathan Scott wrote:
> 
> Certainly wasn't XFS using stack in the initial oops, perhaps
> the lower layers, but I'm a bit sceptical.  Almost certainly
> this is a device mapper snapshot problem, the DM folks should
> be able to analyse it further.
> 
I just want to let you know that there hasn't been any problem until now
using 2.6.10-ac2.  Though I didn't see changes in the dm-snapshot code,
there are quite a lot in dm-crypt.  This seems to be the key: my
problems always appeared with a crypted device mounted.  But I didn't
realize this dependency until now...

Thanks again,
-jo

-- 
-rw-r--r--  1 jo users 63 2005-01-04 22:50 /home/jo/.signature
