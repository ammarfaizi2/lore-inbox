Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVBGEvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVBGEvD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 23:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVBGEvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 23:51:03 -0500
Received: from alt.aurema.com ([203.217.18.57]:63671 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261346AbVBGEu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 23:50:57 -0500
Date: Mon, 7 Feb 2005 15:47:50 +1100
From: Kingsley Cheung <kingsley@aurema.com>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] relayfs crash
Message-ID: <20050207044750.GH27268@aurema.com>
Mail-Followup-To: Tom Zanussi <zanussi@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <41EF4E74.2000304@opersys.com> <20050207030444.GF27268@aurema.com> <16902.61875.963828.513606@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16902.61875.963828.513606@tut.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 10:42:27PM -0600, Tom Zanussi wrote:
> Kingsley Cheung writes:
>  > 
>  > To solve the problem I applied a patch similar to the one you posted
>  > back in July and it fixed the problem.  Could we consider putting this
>  > patch into relayfs? Its similar to the one posted in July 2004, except
>  > it also moves clear_readers() before INIT_WORK in relay_release (is
>  > that acceptable?).
>  > 
> 
> Yes, for some reason the July patch never got applied to that (now
> outdated) 2.6.10 version of relayfs - either that patch or yours
> should fix the problem - thanks for sending it.  In any case, the
> version of relayfs you're using is now ancient history - the latest
> redux versions of relayfs recently posted to lkml have completely
> changed or removed all that code, so you might want to try testing
> with the latest patch (which I'm still reworking parts of even now).
> 
> Thanks,
> 
> Tom
> 

Okay.  I'll give the new patch a go when I can.

Thanks,
-- 
		Kingsley
