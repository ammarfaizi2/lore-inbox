Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265983AbUHLD7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265983AbUHLD7S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 23:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268317AbUHLD7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 23:59:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:29661 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265983AbUHLD7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 23:59:17 -0400
Date: Wed, 11 Aug 2004 20:58:54 -0700
From: Greg KH <greg@kroah.com>
To: James Morris <jmorris@redhat.com>
Cc: Kurt Garloff <kurt@garloff.de>, Chris Wright <chrisw@osdl.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
Message-ID: <20040812035854.GA3556@kroah.com>
References: <20040811222213.GB14744@tpkurt.garloff.de> <Xine.LNX.4.44.0408112120320.15343-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0408112120320.15343-100000@dhcp83-76.boston.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 09:23:19PM -0400, James Morris wrote:
> On Thu, 12 Aug 2004, Kurt Garloff wrote:
> 
> > The rest of the path is still a win IMVHO.
> > 
> > Unfortunately, it has not been discussed here yet.
> 
> Defaulting to the capability module is a separate discussion.  I
> personally don't have a strong opinion on this issue.
> 
> Chris, Stephen, Greg? :-)

I don't really care.  But I think almost every LSM module so far really
wants the capabilities module at the same time, right?  Maybe we should
make it easier to do that than what is necessary today.

thanks,

greg k-h
