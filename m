Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWBGAhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWBGAhp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWBGAhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:37:45 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:14343 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S964898AbWBGAho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:37:44 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Mon, 6 Feb 2006 19:37:13 -0500
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>, suspend2-devel@lists.suspend2.net,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060207003713.GB31153@voodoo>
Mail-Followup-To: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Nigel Cunningham <nigel@suspend2.net>,
	suspend2-devel@lists.suspend2.net, Lee Revell <rlrevell@joe-job.com>,
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1139251682.2791.290.camel@mindpipe> <200602070625.49479.nigel@suspend2.net> <200602070051.41448.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602070051.41448.rjw@sisk.pl>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/06 12:51:40AM +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> This point is valid, but I don't think the users will _have_ _to_ switch to the
> userland suspend.  AFAICT we are going to keep the kernel-based code
> as long as necessary.
> 
> We are just going to implement features in the user space that need not be
> implemented in the kernel.  Of course they can be implemented in the
> kernel, and you have shown that clearly, but since they need not be there,
> we should at least try to implement them in the user space and see how this
> works.
> 
> Frankly, I have no strong opinion on whether they _should_ be implemented
> in the user space or in the kernel, but I think we won't know that until
> we actually _try_.
> 

Some of the stuff belongs in userspace without a doubt, like the UI. But
why was the cryptoapi stuff added to the kernel if everytime someone goes
to use it people yell "That's too much complexity, do it in userspace!"?

> That said, I like the idea and I'm going to work on it.  I'll also appreciate
> any help very much.
> 
> Greetings,
> Rafael

Jim.
