Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUATGiC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 01:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbUATGiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 01:38:02 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:64428 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S265152AbUATGiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 01:38:00 -0500
Date: Mon, 19 Jan 2004 22:37:49 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6][smbfs] smb_open & smb_readpage_sync errors in kernel log
Message-ID: <20040120063749.GA23765@srv-lnx2600.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040119184435.GT8664@srv-lnx2600.matchmail.com> <20040119202243.3d0aa60a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119202243.3d0aa60a.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 08:22:43PM -0800, Andrew Morton wrote:
> Mike Fedyk <mfedyk@matchmail.com> wrote:
> >
> > I've been getting these error messages in my kernel forever, I think even
> > with 2.2 kernels, and it's still there in 2.6:
> > 
> > smb_open: config/SAM open failed, result=-26
> > smb_readpage_sync: config/SAM open failed, error=-26
> > 
> > It does this for several locked system files on the windows machines.
> > 
> > This happens during a find command run on the mounted share from one of my
> > scripts that compares file dates.
> > 
> > Can these printk calls be removed?
> 
> I think so.  We don't want to allow unprivileged users to spam the
> logfiles.

Great!

Thanks Andrew.
