Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129736AbRCLLjD>; Mon, 12 Mar 2001 06:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbRCLLix>; Mon, 12 Mar 2001 06:38:53 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:41317 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129736AbRCLLin>; Mon, 12 Mar 2001 06:38:43 -0500
Date: Mon, 12 Mar 2001 05:37:40 -0600
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, elenstev@mesatop.com,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Rename all derived CONFIG variables
Message-ID: <20010312053740.C16340@mandrakesoft.mandrakesoft.com>
In-Reply-To: <20736.984380602@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <20736.984380602@ocs3.ocs-net>; from Keith Owens on Mon, Mar 12, 2001 at 06:03:22PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2001 at 06:03:22PM +1100, Keith Owens wrote:
> In 2.4.2-ac18 there are 130 CONFIG options that are always derived from
> other options, the user has no control over them.  It is useful for the
> kernel build process to know which variables are derived and which
> variables the user can control.  There are also 6 CONFIG options that

Yes, it is.  However, I don't see a reason to use a different namespace
for them.  At least some of the options below might become non-derived
options again, and having that knowledge spread out over most of the
kernel tree doesn't make any sense to me.
