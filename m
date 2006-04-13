Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWDMVvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWDMVvB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 17:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWDMVvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 17:51:01 -0400
Received: from uproxy.gmail.com ([66.249.92.170]:37001 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964986AbWDMVvA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 17:51:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JNqVcmUQlhSp9h/3gVgzgOsoQcYVVq3ICytaeoda34FhdIvS96S4UKoY/DxBaK3yxeuaC3AEstZhvwDTKfNAvdim33qPFk38GWebbAmEk/0C/IO7Yye+oZRj/V5YRDM9eRZtX9+MzXH1E8GLg2DSpxTQcv3buh9eCYq709z910g=
Message-ID: <625fc13d0604131450i2cbfcc1fie787daea380b7c66@mail.gmail.com>
Date: Thu, 13 Apr 2006 16:50:58 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: [PATCH 3/4] Remove unchecked flags
Cc: "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>,
       "Andrew Morton" <akpm@osdl.org>, "Thomas Gleixner" <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <1144955886.2697.78.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060413165153.GD30574@wohnheim.fh-wedel.de>
	 <20060413165434.GG30574@wohnheim.fh-wedel.de>
	 <625fc13d0604131108w68612124ga77fb5fd9f0a408c@mail.gmail.com>
	 <1144955886.2697.78.camel@shinybook.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/06, David Woodhouse <dwmw2@infradead.org> wrote:
> On Thu, 2006-04-13 at 13:08 -0500, Josh Boyer wrote:
> > As a side note, these will also need to be removed from the mtd-utils
> > tree.  The switch to git meant that mtd-utils has it's own copy of the
> > sanitized headers.  The patch for mtd-abi.h should apply there as
> > well.
>
> The idea is that include/mtd/ is sanitised for userspace, and those
> headers should be identical. Having switched to git and separated the
> userspace and kernel repositories, I hadn't yet worked out how to
> address that.

We sorta addressed it already.  The repositories each have their own
copy of those files.  They should still be identical, which means
double maintenance on them.  That sucks, but I don't know of a better
way to do it offhand.

josh
