Return-Path: <linux-kernel-owner+w=401wt.eu-S936396AbWLIIvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936396AbWLIIvF (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 03:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936410AbWLIIvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 03:51:05 -0500
Received: from mx1.suse.de ([195.135.220.2]:39879 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936396AbWLIIvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 03:51:02 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Sat, 9 Dec 2006 19:51:09 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17786.30973.594360.165898@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000 of 5] md: Assorted minor fixes for mainline
In-Reply-To: message from Andrew Morton on Friday December 8
References: <20061208120132.21203.patches@notabene>
	<20061208160455.05a81359.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday December 8, akpm@osdl.org wrote:
> 
> md-change-lifetime-rules-for-md-devices.patch still has a cloud over its
> head (Jiri Kosina <jikos@jikos.cz>'s repeatable failure), so I staged these
> new patches as below:
> 
> 
>  md-fix-innocuous-bug-in-raid6-stripe_to_pdidx.patch
>  #
>  md-conditionalize-some-code.patch
> +md-remove-some-old-ifdefed-out-code-from-raid5c.patch
> +md-return-a-non-zero-error-to-bi_end_io-as-appropriate-in-raid5.patch
> +md-assorted-md-and-raid1-one-liners.patch
>  md-change-lifetime-rules-for-md-devices.patch
> +md-close-a-race-between-destroying-and-recreating-an-md-device.patch
> +md-allow-mddevs-to-live-a-bit-longer-to-avoid-a-loop-with-udev.patch
> 
> So the last three are maybe-not-for-2.6.20.
> 
> Does that sounds sane?

Yes, perfectly sane ... though I still hope to nail that bug :-)

Thanks,
NeilBrown
