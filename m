Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754761AbWKROjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761AbWKROjL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 09:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754768AbWKROjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 09:39:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:42259 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1754761AbWKROjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 09:39:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=EYkKvXkMWkF4BMv7HXxD07DetnWIeCsGoT6iH0cJLzaBIdQtYuWJQ3N5a1i4YTMYD4erP3W0VaXLDzejmjvQXETSsX3oACDMMKrPHcRuiJAIyTXfGL9XSgDRyY9xkqRMID+GUOr+xlAroQ84reTxU35jDIkHQd4rvOCqkMv5Xx4=
Date: Sat, 18 Nov 2006 17:39:03 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Pavol Gono <palo.gono@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tests of kernel modules
Message-ID: <20061118143903.GA4974@martell.zuzino.mipt.ru>
References: <52e895540611171923p425e30feh832c693d7529b6a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52e895540611171923p425e30feh832c693d7529b6a7@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 04:23:06AM +0100, Pavol Gono wrote:
> After resolving http://bugzilla.kernel.org/show_bug.cgi?id=7481
> I was thinking about possibilities how to prevent such bugs with
> testing. Usually just few insmods and rmmods show, whether the
> initialization and cleanup code of module is ok or not.
>
> I created a script which do the automatic job of finding all modules
> and inserting/removing them (see attachment). On my Lifebook E8110,
> kernel 2.6.18.2, the following modules were problematic:
> arptable_filter pktgen rfcomm rpcsec_gss_krb5 sdhci xt_NFQUEUE
> Kernel logs usually say "BUG: unable to handle kernel paging request
> at virtual address ..." or "BUG: unable to handle kernel NULL pointer
> dereference at virtual address 00000000".
>
> When trying knoppix 5.0.1, my script causes total freeze quickly.
> Is it worth to report each buggy module to bugzilla?

Yes. To mainline bugzilla. or to relevant mailing lists (linux-kernel,
netdev, ...) Be sure to use latest mainline kernel.

