Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWJ1W6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWJ1W6u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 18:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWJ1W6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 18:58:50 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:64327 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964905AbWJ1W6t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 18:58:49 -0400
Date: Sat, 28 Oct 2006 23:58:45 +0100
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: NFS problem (r/o filesystem) with 2.6.19-rc3
Message-ID: <20061028225845.GA5185@deepthought.linux.bogus>
References: <20061028184226.GA1225@deepthought.linux.bogus> <20061028142228.da7350c2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20061028142228.da7350c2.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 02:22:28PM -0700, Andrew Morton wrote:
> On Sat, 28 Oct 2006 19:42:27 +0100
> Ken Moffat <zarniwhoop@ntlworld.com> wrote:
> 
> >  But if I then try to touch a file I find the filesystem is r/o -
> > root@bluesbreaker /home/ken #touch /nfs/bluesbreaker/boot/vmlinuz-2.6.18-sda8 
> > touch: cannot touch `/nfs/bluesbreaker/boot/vmlinuz-2.6.18-sda8':
> > Read-only file system
> > 
> >  This filesystem is a 'staging' area where whichever of my desktop
> > machines are up can write.  From a different box using a 2.6.17.13
> > kernel the filesystem is r/w.  The system log on the machine running
> > rc3 only shows that rsync ended in error, there are no associated
> > kernel messages. 
> > 
> >  Suggestions, please ?
> > 
> 
> Is it this: http://lkml.org/lkml/2006/10/18/264 ?

Yes, I think it is. 

Ken 
-- 
das eine Mal als Tragödie, das andere Mal als Farce
