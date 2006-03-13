Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWCMJNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWCMJNH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 04:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWCMJNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 04:13:06 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:52752 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932185AbWCMJNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 04:13:05 -0500
Date: Mon, 13 Mar 2006 10:12:54 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Petr Vandrovec <petr@vandrovec.name>, linux-kernel@vger.kernel.org,
       sam@ravenborg.org, kai@germaschewski.name
Subject: Re: [PATCH] Do not rebuild full kernel tree again and again...
Message-ID: <20060313091254.GA28231@mars.ravnborg.org>
References: <20060312172511.GA17936@vana.vc.cvut.cz> <20060312174250.GA1470@mars.ravnborg.org> <44150CD7.604@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44150CD7.604@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 05:10:31PM +1100, Nick Piggin wrote:
> Sam Ravnborg wrote:
> 
> >This issue has been discussed with Paul D. Smith which also provided
> >a patch similar to yours.
> >The patch is in the kbuild queue for 2.6.17.
> >But we also agreed to postpose this change in make until next stable
> >release. So if you update your make to latest CVS version you will no
> >longer see this misbehaviour.
> >And when 2.6.17 opens up kbuild will be 'fixed' in mainline kernel.
> >
> 
> So what's going to be done about 2.6.16?
> 
> I'm seeing this behaviour too in -rc6 and it is a bad regression
> for a developer. I assume there will be some workaround?
I assume debian soon will update make to current version from CVS that
has this behaviour removed.

	Sam
