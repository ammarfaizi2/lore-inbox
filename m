Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWDMS7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWDMS7G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWDMS7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:59:06 -0400
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:50312 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S932450AbWDMS7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:59:05 -0400
Date: Thu, 13 Apr 2006 14:58:59 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: jgmtfia Mr <jgmtfia@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: NFS data corruption
Message-ID: <20060413185859.GA30387@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	jgmtfia Mr <jgmtfia@gmail.com>, linux-kernel@vger.kernel.org
References: <16e19f4b0604122025s310f1989j1c301dd5d90f5059@mail.gmail.com> <1144898847.8056.21.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144898847.8056.21.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2006 at 11:27:27PM -0400, Trond Myklebust wrote:
> On Wed, 2006-04-12 at 21:25 -0600, jgmtfia Mr wrote:
> > When transferring from a 2.6.16 nfs client to a 2.6.16.1 server I get
> > data corruption.  There is no indication of any problems in any log on
> > the client or server.  It does *not* happen when transferring from
> > server to client.
> 
> Do you get corruption with 2.6.17-rc1? That has a fix for a known
> corruption issue.
 
Trond,

Could you point out the particular commit, or the patch from your patch
series?

[On Tuesday, I tried linux-2.6.16-NFS_ALL on a host that is re-exporting
a NetApp NFS mount via Samba, and I got thousands of file locks that
weren't released, so I had to discard NFS_ALL for now, until I have time
to look closer.]

	-Bill
