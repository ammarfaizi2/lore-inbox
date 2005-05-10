Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVEJIv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVEJIv4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 04:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVEJIv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 04:51:56 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:63133 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261441AbVEJIvx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 04:51:53 -0400
Date: Tue, 10 May 2005 10:52:10 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <20050510085210.GA17601@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050508184229.957247000@abc> <20050509180411.6cff1941.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050509180411.6cff1941.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 217.231.53.1
Subject: Re: [DVB patch 00/37] DVB updates for 2.6.12-rc4
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 Andrew Morton wrote:
> Johannes Stezenbach <js@linuxtv.org> wrote:
> > here are a bunch of patches from linuxtv.org CVS. Nothing
> > exciting, just bugfixes, cleanups and support for a number
> > of new card variants.
> 
> Do you view this as 2.6.12 material?

Yes, all of it is well tested and has been in CVS for a while.

> I notice that Greg's tree changes dvb_class to be of type class_simple, so
> there may be interactions between your stuff and
> gregkh-01-driver-gregkh-driver-022_class-11-drivers.patch.  We'll see. 

OK, I'll check that.

> I notice you have a lot of things like:
> 
>   Switch analog output of the Crystal sound chip to left/stereo/right mode.
>   This will fix problems with some (most?) channels which do not encode 2-channel
>   audio correctly. (Oliver Endriss)
> 
> In future, please try to gather Signed-off-by: lines for these
> contributions, thanks.

How should we handle this with CVS? Should people add a
Signed-off-by: line to the CVS commit log? If they don't,
can I assume that "by policy" the Signed-off-by: line for
the committer is implicit? Or do I have to bug them to
mail me the Signed-off-by: line?


Thanks,
Johannes
