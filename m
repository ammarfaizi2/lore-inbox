Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbUABUf7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265656AbUABUf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:35:58 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:14610 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265655AbUABUf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:35:57 -0500
Date: Fri, 2 Jan 2004 20:35:55 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Valdis.Kletnieks@vt.edu
Cc: Claas Langbehn <claas@rootdir.de>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: XFS forced shutdown with kernel 2.6.0
Message-ID: <20040102203555.A1420@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Valdis.Kletnieks@vt.edu, Claas Langbehn <claas@rootdir.de>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <20040102095051.GA19872@rootdir.de> <20040102182921.A27237@infradead.org> <200401022027.i02KRe7X013502@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200401022027.i02KRe7X013502@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Fri, Jan 02, 2004 at 03:27:40PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 03:27:40PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 02 Jan 2004 18:29:21 GMT, Christoph Hellwig said:
> 
> > I've seen the same bug a few times lately, but only if I had previous
> > memory corruption due to code I was hacking on.  Can you reproduce it
> > without the nvidia module loaded as that is likely source of such
> > corruption?
> 
> While you're at it, see what *else* you can turn off - RAID, devfs, NFS, etc.
> 
> It's equally likely that you're tripping over some other kernel module's
> use-after-free or chase-the-wrong-pointer bug.  I've seen a lot more bugfixes
> for *those* on this list than cases where "I turned off nvidia and it started
> working".

The difference is that I can look at those while I can't look at nvidias
driver. Pretty simple.

