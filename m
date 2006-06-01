Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWFAUsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWFAUsW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 16:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965304AbWFAUsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 16:48:22 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:62664 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965298AbWFAUsU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 16:48:20 -0400
Date: Thu, 1 Jun 2006 15:47:56 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
       Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       James Morris <jmorris@namei.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Erez Zadok <ezk@cs.sunysb.edu>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/13: eCryptfs] eCryptfs Patch Set
Message-ID: <20060601204756.GB10942@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060513033742.GA18598@hellewell.homeip.net> <20060520095740.GA12237@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520095740.GA12237@infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2006 at 10:57:40AM +0100, Christoph Hellwig wrote:
>  - please split all the generic stackable filesystem passthorugh routines
>    into a separated stackfs layer, in a few files in fs/stackfs/ that
>    you depend on.  They'll get _GPL exported to all possible stackable
>    filesystem.  They'll need their own store underlying object helpers,
>    but that can be made to work by embedding the generic stackfs data
>    as first thing in the ecryptfs object.

We are looking into ways to do this in a way that makes sense, since
there are so many varieties of stackable filesystems out there (e.g.,
gzipfs, unionfs, ecryptfs, etc.), each filesystem having its own
unique characteristics that affect how the ``stackable'' components
take form. This is something we are investigating for the future, but
in the meantime, we would like to have eCryptfs merged in as it is
currently implemented.

Mike
