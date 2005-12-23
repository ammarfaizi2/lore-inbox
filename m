Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030525AbVLWPAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030525AbVLWPAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 10:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030540AbVLWPAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 10:00:38 -0500
Received: from pat.uio.no ([129.240.130.16]:137 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030525AbVLWPAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 10:00:38 -0500
Subject: Re: nfs insecure_locks / Tru64 behaviour
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ron Peterson <rpeterso@MtHolyoke.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051223143950.GA1330@mtholyoke.edu>
References: <20051222133623.GE7814@mtholyoke.edu>
	 <1135293713.3685.9.camel@lade.trondhjem.org>
	 <20051223013933.GB22949@mtholyoke.edu>
	 <1135302325.3685.69.camel@lade.trondhjem.org>
	 <20051223022126.GC22949@mtholyoke.edu>
	 <1135327075.8167.6.camel@lade.trondhjem.org>
	 <20051223133801.GA9321@mtholyoke.edu>
	 <1135345813.8167.155.camel@lade.trondhjem.org>
	 <20051223143950.GA1330@mtholyoke.edu>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 16:00:25 +0100
Message-Id: <1135350025.8167.157.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.143, required 12,
	autolearn=disabled, AWL 1.81, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 09:39 -0500, Ron Peterson wrote:
> On Fri, Dec 23, 2005 at 02:50:12PM +0100, Trond Myklebust wrote:
> > On Fri, 2005-12-23 at 08:38 -0500, Ron Peterson wrote:
> > > The gid's of the kmw group match on both sides.  The problem happens
> > > whether root squashing is on or off.  Unless the execute bit for 'other'
> > > is turned on for the parent directory, the file appears to be locked
> > > when being accessed from the nfs client (tru64) side.
> > > 
> > > My theory may be wrong, but the problem still exists.
> > 
> > Possibly, but that sounds like it might be a tru64 bug. As you can see,
> > a Linux client has no such problems:
> 
> Not unlikely.  I was hoping it was a bug that the insecure_locks options
> was meant to work around.  Perhaps that's not possible.  :(

As I said, insecure_locks has nothing to do with file access.

Cheers,
  Trond

