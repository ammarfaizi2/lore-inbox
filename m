Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267435AbTBIT4w>; Sun, 9 Feb 2003 14:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267436AbTBIT4w>; Sun, 9 Feb 2003 14:56:52 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:63506 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267435AbTBIT4w>; Sun, 9 Feb 2003 14:56:52 -0500
Date: Sun, 9 Feb 2003 20:06:26 +0000
From: Christoph Hellwig <hch@infradead.org>
To: jmjones@jmjones.com
Cc: Christoph Hellwig <hch@infradead.org>,
       "Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
       torvalds@transmeta.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030209200626.A7704@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	jmjones@jmjones.com, "Stephen D. Smalley" <sds@epoch.ncsc.mil>,
	greg@kroah.com, torvalds@transmeta.com,
	linux-security-module@wirex.com, linux-kernel@vger.kernel.org
References: <20030206151820.A11019@infradead.org> <Pine.LNX.3.96.1030207205056.31221A-100000@dixie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1030207205056.31221A-100000@dixie>; from jmjones@jmjones.com on Fri, Feb 07, 2003 at 09:20:08PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 09:20:08PM -0500, jmjones@jmjones.com wrote:
> I disagree.  The code submitted BOTH addresses the current needs and
> "vaguely anticipated future needs" (which I shall define as VAFN).

What is the "current needs" given that selinux is the only module actually
using it and it's neither in a mergeable shape nor is it legally clear
whether it can be merged?

> Open your mind.  LSM supports both all current solutions for object-level
> security AND provides a valid basis for moving Linux toward providing, AS
> AN OPTION, true security.  Personally, I don't think LSM is the "be all
> and end all" of a security interface, at this point, but I *do* think it's
> the best first-draft of a system that can lead to that end.

you don't get tru security by adding hooks.  security needs a careful
design and more strict access control policy can but don't have to be part
of that design.

> What's your REAL problem?  Somebody stepping on your territory?

The real problem is adding mess to the kernel.

