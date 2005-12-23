Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030537AbVLWOjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030537AbVLWOjy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 09:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030539AbVLWOjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 09:39:53 -0500
Received: from ambr.mtholyoke.edu ([138.110.1.10]:1297 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S1030537AbVLWOjx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 09:39:53 -0500
From: Ron Peterson <rpeterso@MtHolyoke.edu>
Date: Fri, 23 Dec 2005 09:39:50 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs insecure_locks / Tru64 behaviour
Message-ID: <20051223143950.GA1330@mtholyoke.edu>
References: <20051222133623.GE7814@mtholyoke.edu> <1135293713.3685.9.camel@lade.trondhjem.org> <20051223013933.GB22949@mtholyoke.edu> <1135302325.3685.69.camel@lade.trondhjem.org> <20051223022126.GC22949@mtholyoke.edu> <1135327075.8167.6.camel@lade.trondhjem.org> <20051223133801.GA9321@mtholyoke.edu> <1135345813.8167.155.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1135345813.8167.155.camel@lade.trondhjem.org>
Organization: Mount Holyoke College
X-Operating-System: Debian GNU/Linux
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 02:50:12PM +0100, Trond Myklebust wrote:
> On Fri, 2005-12-23 at 08:38 -0500, Ron Peterson wrote:
> > The gid's of the kmw group match on both sides.  The problem happens
> > whether root squashing is on or off.  Unless the execute bit for 'other'
> > is turned on for the parent directory, the file appears to be locked
> > when being accessed from the nfs client (tru64) side.
> > 
> > My theory may be wrong, but the problem still exists.
> 
> Possibly, but that sounds like it might be a tru64 bug. As you can see,
> a Linux client has no such problems:

Not unlikely.  I was hoping it was a bug that the insecure_locks options
was meant to work around.  Perhaps that's not possible.  :(

Skøl.

-- 
Ron Peterson
Network & Systems Manager
Mount Holyoke College
http://pks.mtholyoke.edu:11371/pks/lookup?search=0xB6D365A1&op=vindex
