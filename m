Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268285AbUHXUj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268285AbUHXUj2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268280AbUHXUj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:39:28 -0400
Received: from verein.lst.de ([213.95.11.210]:15783 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268285AbUHXUiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:38:52 -0400
Date: Tue, 24 Aug 2004 22:38:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       reiser@namesys.com, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040824203844.GA26999@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
	reiser@namesys.com, linux-fsdevel@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040824202521.GA26705@lst.de> <1093379718.817.63.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093379718.817.63.camel@krustophenia.net>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 04:35:18PM -0400, Lee Revell wrote:
> On Tue, 2004-08-24 at 16:25, Christoph Hellwig wrote:
> >    - O_DIRECTORY opens succeed on all files on reiser4.  Besides breaking
> >      .htaccess handling in apache and glibc compilation this also renders
> >      this flag entirely useless and opens up the races it tries to
> >      prevent against cmpletely useless
> 
> So `find -type d' would list every file on the system?

the find I have here is using lstat and not open with O_DIRECTORY, so
no.

