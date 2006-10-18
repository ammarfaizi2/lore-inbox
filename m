Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423096AbWJRW3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423096AbWJRW3z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 18:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423099AbWJRW3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 18:29:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:18341 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1423096AbWJRW3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 18:29:53 -0400
Date: Wed, 18 Oct 2006 14:21:46 -0700
From: Greg KH <greg@kroah.com>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: Greg.Chandler@wellsfargo.com, linux-kernel@vger.kernel.org
Subject: Re: kernel oops with extended serial stuff turned on...
Message-ID: <20061018212146.GA5206@kroah.com>
References: <335DD0B75189FB428E5C32680089FB9F803FDE@mtk-sms-mail01.digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335DD0B75189FB428E5C32680089FB9F803FDE@mtk-sms-mail01.digi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 04:16:54PM -0500, Kilau, Scott wrote:
> Hi Greg C,
> 
> > -----Original Message-----
> > From: Greg.Chandler@wellsfargo.com 
> > [mailto:Greg.Chandler@wellsfargo.com] 
> > Sent: Wednesday, October 18, 2006 4:07 PM
> > To: Kilau, Scott
> > Cc: linux-kernel@vger.kernel.org
> > Subject: RE: kernel oops with extended serial stuff turned on...
> > 
> > 
> > Should that be made a permanent patch then? 
> 
> In my out-of-tree drivers, yes, it was the correct way to fix
> the problem.
> 
> I am probably not the best one to ask about the
> other serial drivers however...
> 
> The "DEVFS" stuff was removed by Greg KH, I believe, so
> he  probably is the best to decide upon the correct way of
> "fixing" it.
> 
> Ie, I am not sure whether his intentions were to slide in a
> new patch on it later on to fix the problem with trying to
> register with sysfs/udev twice...

I don't understand, what problem is occuring here?  Who is trying to
register with sysfs twice?

thanks,

greg k-h
