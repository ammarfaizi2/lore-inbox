Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030525AbVKPW0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030525AbVKPW0n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030526AbVKPW0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:26:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:49057 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030525AbVKPW0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:26:42 -0500
Date: Wed, 16 Nov 2005 14:10:47 -0800
From: Greg KH <greg@kroah.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: "Gross, Mark" <mark.gross@intel.com>, Pavel Machek <pavel@ucw.cz>,
       Dave Jones <DaveJ@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051116221047.GA12830@kroah.com>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com> <20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132172445.25230.73.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 07:20:45AM +1100, Nigel Cunningham wrote:
> 
> I've also split the one patch that most people see into what is
> currently about 225 smaller patches, each adding only one small part, am
> writing descriptions for them all and am preparing to build a git tree
> from it.

That's great, I didn't know you were doing this.

I'd recommend using quilt instead of git for something like this,
because the odds that you will need to change something in patch number
132 out of 225 is pretty good :)

thanks,

greg k-h
