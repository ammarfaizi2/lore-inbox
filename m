Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293174AbSBYRUh>; Mon, 25 Feb 2002 12:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291809AbSBYRUb>; Mon, 25 Feb 2002 12:20:31 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:22769
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293174AbSBYRUI>; Mon, 25 Feb 2002 12:20:08 -0500
Date: Mon, 25 Feb 2002 09:20:48 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Dan Maas <dmaas@dcine.com>
Cc: "Rose, Billy" <wrose@loislaw.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020225172048.GV20060@matchmail.com>
Mail-Followup-To: Dan Maas <dmaas@dcine.com>,
	"Rose, Billy" <wrose@loislaw.com>, linux-kernel@vger.kernel.org
In-Reply-To: <fa.n4lfl6v.h4chor@ifi.uio.no> <05cb01c1be1e$c490ba00$1a01a8c0@allyourbase>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05cb01c1be1e$c490ba00$1a01a8c0@allyourbase>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 12:06:29PM -0500, Dan Maas wrote:
> > but I don't want a Netware filesystem running on Linux, I
> > want a *native* Linux filesystem (i.e. ext3) that has the
> > ability to queue deleted files should I configure it to.
> 
> Rather than implementing this in the filesystem itself, I'd first try
> writing a libc shim that overrides unlink(). You could copy files to safety,
> or do anything else you want, before they actually get deleted...

Yep, more portable.

Now the question is: Is there already something written?
