Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVCGTPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVCGTPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 14:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVCGTMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 14:12:30 -0500
Received: from mail.logixonline.com ([216.201.128.36]:32018 "EHLO
	mail.logixonline.com") by vger.kernel.org with ESMTP
	id S261268AbVCGTIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:08:52 -0500
Date: Mon, 7 Mar 2005 13:08:49 -0600
From: Chuck Campbell <campbell@accelinc.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: campbell@accelinc.com, linux-kernel@vger.kernel.org
Subject: Re: NFS problem in 2.4.21 (RHEL ES 3 upd 2)
Message-ID: <20050307190849.GB18702@helium.inexs.com>
Reply-To: campbell@accelinc.com
Mail-Followup-To: Chuck Campbell <campbell@accelinc.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <20050307163711.GB11949@helium.inexs.com> <1110218547.11489.32.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1110218547.11489.32.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 01:02:27PM -0500, Trond Myklebust wrote:
> må den 07.03.2005 Klokka 10:37 (-0600) skreiv Chuck Campbell:
> > I've just built a cluster of dual Opteron boxes, running RHEL 3 update 2
> > x86_64 OS.
> > 
> > I have problems creating files larger than 2GB on an NFS mounted filesystem.
> > 
> 
> Are you perhaps using NFSv2? If so, I suggest you try NFSv3, as the
> NFSv2 protocol does not support 64-bit file sizes.

OK, that fixed it.  It certainly wasn't apparent from the docs I plowed 
through for the last two days, and I never turned up that gem on Google
either.

Even the NFS-howto didn't point this out, so I'll submit some update info 
to them.  Sorry for the noise.

-chuck

