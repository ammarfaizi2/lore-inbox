Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWCBSFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWCBSFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 13:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWCBSFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 13:05:15 -0500
Received: from proof.pobox.com ([207.106.133.28]:6119 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S932270AbWCBSFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 13:05:13 -0500
Date: Thu, 2 Mar 2006 11:05:09 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS doen't uniformly copy timestamps to server
Message-Id: <20060302110509.2ae9c5d9.dickson@permanentmail.com>
In-Reply-To: <1141261063.26382.20.camel@netapplinux-10.connectathon.org>
References: <20060301173554.f2d18939.dickson@permanentmail.com>
	<1141261063.26382.20.camel@netapplinux-10.connectathon.org>
X-Mailer: Sylpheed version 2.2.0beta7 (GTK+ 2.8.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2006 16:57:43 -0800, Trond Myklebust wrote:

> On Wed, 2006-03-01 at 17:35 -0700, Paul Dickson wrote:
> > Within a NFS mount directory:
> > 	cp -a file1 file2	# Timestamp not copied
> > 	mv file1 file2 		# Timestamp not copied
> > 	touch -r file1 file2	# Timestamp copied
> > 
> > More data is at:
> >   https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=183208
> > 
> > This currently happens with 2.6.16rc5-git3
> > 
> > Is this a problem with the NFS server or am I applying the wrong options?
> 
> The RedHat bugzilla tracks RedHat bugs. For kernel bugs, see
> bugzilla.kernel.org.
> 
> From your description, it looks very much like the issue being tracked
> in
> 
>    http://bugzilla.kernel.org/show_bug.cgi?id=6127
> 
> Feel free to try the proposed patch.

The patch solves my problem (when installed on the client side).

Thanks.

	-Paul

