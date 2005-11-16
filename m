Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbVKPRAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbVKPRAF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 12:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030414AbVKPRAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 12:00:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:58765 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030417AbVKPRAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 12:00:04 -0500
Date: Wed, 16 Nov 2005 08:44:29 -0800
From: Greg KH <greg@kroah.com>
To: "Gross, Mark" <mark.gross@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@redhat.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051116164429.GA5630@kroah.com>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 08:10:19AM -0800, Gross, Mark wrote:
> I worry that this is just adding more thrash to a historically unstable
> implementation.  How long do we users have to wait for a swsusp
> implementation where we don't have to worry about breaking from one
> kernel release to the next?

Never, you are hereby consigned to always have a broken swsusp
implementation on your machines.

There, feel better?  Or perhaps you could join in and help with the
current effort to make things better...

> I agree with this post http://lkml.org/lkml/2005/9/15/125 and note that
> making too large of a change thrashes the users a lot and if it doesn't
> solve a real problem or enable something critical, why make the changes?

Ok, so you are happy with what we currently have in the kernel tree
today?  Great, use that, I know it works for me and I'm happy with it...

Please, everyone realize that Nigel's code is not going to be merged
into mainline as it is today.  He knows it, and everyone else involved
knows it.  Nigel also knows the proper procedure for getting his changes
into mainline, if he so desires, as we all sat in a room last July and
discussed this (lwn.net has a summary somewhere about it too...)

So, here's Pavel trying to make things better and people are complaining
about it.  Argue that the technical points are invalid (like Dave did.)
But don't just sit around and kvetch, that doesn't help out anyone.

thanks,

greg k-h
