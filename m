Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTEHTgA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 15:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTEHTgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 15:36:00 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:14856 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262050AbTEHTfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 15:35:52 -0400
Date: Thu, 8 May 2003 20:48:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030508204826.A21216@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200305081546_MC3-1-3809-363D@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305081546_MC3-1-3809-363D@compuserve.com>; from 76306.1226@compuserve.com on Thu, May 08, 2003 at 03:43:37PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 03:43:37PM -0400, Chuck Ebbert wrote:
> > you can write a stackable filesystem on linux, too and intercept any
> > I/O request.  You just have to do it through a sane interface, mount
> > and not by patching the syscall table - which you can do under
> > windows either.  (at least not as part of the public API).
> 
>   So when I register my filesystem, can I indicate that I want to be
> layered over top of the ext3 driver

Yes.

> and get control anytime someone
> mounts an ext3 fileystem,

no.

