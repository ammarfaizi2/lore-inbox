Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267866AbTBEIhs>; Wed, 5 Feb 2003 03:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267867AbTBEIhs>; Wed, 5 Feb 2003 03:37:48 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:50439 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267866AbTBEIhr>; Wed, 5 Feb 2003 03:37:47 -0500
Date: Wed, 5 Feb 2003 08:47:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: torvalds@transmeta.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030205084717.A16212@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, torvalds@transmeta.com,
	linux-security-module@wirex.com, linux-kernel@vger.kernel.org
References: <20030205041538.GA16823@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030205041538.GA16823@kroah.com>; from greg@kroah.com on Tue, Feb 04, 2003 at 08:15:38PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 08:15:38PM -0800, Greg KH wrote:
> Hi,
> 
> These changesets include some new LSM hooks, all of which have been sent
> to lkml with no dissenting comments.  Some of these hooks are the same
> ones I sent for 2.5.58, but were not picked up.  These include hooks for
> syslog and sysctl, restores some previously lost hooks, and reworked the
> hooks for the security structures for private files.

I still don't see the issue of each LSM module having to duplicate the list
of sysctls beeing addressed.  Coul you please work something out for that
before sending it for inclusion?

