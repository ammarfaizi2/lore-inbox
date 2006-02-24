Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932640AbWBXXRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbWBXXRw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 18:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbWBXXRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 18:17:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:3265 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932640AbWBXXRw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 18:17:52 -0500
Date: Fri, 24 Feb 2006 23:17:49 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Kendrick Smith <kmsmith@umich.edu>, Andy Adamson <andros@umich.edu>,
       neilb@cse.unsw.edu.au
Subject: Re: [PATCH 12/13] "const static" vs "static const" in nfs4
Message-ID: <20060224231749.GH27946@ftp.linux.org.uk>
References: <200602242149.42735.jesper.juhl@gmail.com> <1140821964.3615.95.camel@lade.trondhjem.org> <9a8748490602241501q550488baqad63df65f4dd8623@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490602241501q550488baqad63df65f4dd8623@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 12:01:32AM +0100, Jesper Juhl wrote:
> No need for that. It's just something that ICC complains about
> "storage class not being first" - gcc doesn't care.

Neither does C99, so ICC really should either STFU or make that warning
independent from the rest and possible to turn off...
