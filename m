Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWDSBH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWDSBH6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 21:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWDSBH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 21:07:58 -0400
Received: from pproxy.gmail.com ([64.233.166.180]:61788 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750834AbWDSBH5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 21:07:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q5lPeAwbgJkY+jMi4NZwNUPtJyDb8T6LnK41i5bFgv4UpKlOr9w5/Es6Su5ImirC+CJer6wNCdvA4GxTpP6ZbbH3nDDpY0gvzG4Ql51YJsyP53aELV85EVHdEzC+JWRfmnrAc5UKzn6SDIHBDtMRMkpYS4HL1WlGdT7yM7+F8QM=
Message-ID: <35fb2e590604181807x44ab9631m98cd0aa464d40658@mail.gmail.com>
Date: Wed, 19 Apr 2006 02:07:57 +0100
From: "Jon Masters" <jonathan@jonmasters.org>
To: "David Lang" <dlang@digitalinsight.com>
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0604181637090.22439@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060418234156.GA28346@apogee.jonmasters.org>
	 <Pine.LNX.4.62.0604181550380.22439@qynat.qvtvafvgr.pbz>
	 <35fb2e590604181715o5c381407ya80bdc3beedc5b68@mail.gmail.com>
	 <Pine.LNX.4.62.0604181637090.22439@qynat.qvtvafvgr.pbz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/06, David Lang <dlang@digitalinsight.com> wrote:

> 2. I thought I heard Linus state recently that makeing something only work
> as a module was unacceptable, officially stateing that modules are
> required and monolithic kernels aren't allowed anymore doesn't sound
> reasonable.

It works fine with or without modules - it's just that if you don't
have the module then you have to supply the firmware for yourself.
It's just like any of the other MODULE_ tags.

Jon.
