Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWCEWkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWCEWkD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 17:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWCEWkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 17:40:02 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30472 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751897AbWCEWkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 17:40:00 -0500
Date: Sun, 5 Mar 2006 23:39:39 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Ben Dooks <ben-linux@fluff.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Keith Ownes <kaos@ocs.com.au>
Subject: Re: kbuild - status on section mismatch warnings
Message-ID: <20060305223939.GA16148@mars.ravnborg.org>
References: <20060305193012.GA14838@mars.ravnborg.org> <20060305200659.GD27946@ftp.linux.org.uk> <20060305215853.GA14998@mars.ravnborg.org> <20060305220401.GA25816@home.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060305220401.GA25816@home.fluff.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 10:04:01PM +0000, Ben Dooks wrote:
 > 
> > And this is unfortunate since we cannot do a full check, but we do a
> > better job than before and warn for many of the trivial cases.
> > Judging the amount of warnings already generated this is worth checking.
> 
> I think the best way to be with an extension to sparse to
> check calls from non-init marked code do not to go to items
> marked init unless forced to.

Should be doable yes. Maybe even with current infrastructure?
The advantage being that the check in modpost is run each time you build
your modules so much harder to overlook.

	Sam
