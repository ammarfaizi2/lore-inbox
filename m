Return-Path: <linux-kernel-owner+w=401wt.eu-S1750937AbXADRm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbXADRm3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbXADRm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:42:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43111 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbXADRm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:42:28 -0500
Date: Thu, 4 Jan 2007 17:42:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: useless asm/page.h exported to userspace for some architectures
Message-ID: <20070104174227.GA7593@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Frysinger <vapier.adi@gmail.com>, linux-kernel@vger.kernel.org
References: <8bd0f97a0701032300u1b1b45c7jebd3dbddfb1df27d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bd0f97a0701032300u1b1b45c7jebd3dbddfb1df27d@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 02:00:20AM -0500, Mike Frysinger wrote:
> most architectures (pretty much everyone but like x86/x86_64/s390)
> export empty asm/page.h headers ... considering how useless these are,
> why bother exporting them at all ?  clearly userspace is unable to
> rely on it across architectures, so by making it available to the two
> most common (x86/x86_64), applications crop up that build "fine" on
> them but fail just about everywhere else

It should not be exported to userspace at all.  Care to submit a patch?

