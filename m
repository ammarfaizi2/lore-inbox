Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUHCA3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUHCA3A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUHCA26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:28:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:47835 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264668AbUHCA1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:27:24 -0400
Date: Mon, 2 Aug 2004 16:46:36 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       dsaxena@plexity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH TRIVIAL] Add Intel IXP2400 & IXP2800 to PCI.ids
Message-ID: <20040802234635.GA16394@kroah.com>
References: <20040716170832.GA4997@plexity.net> <40F81020.5010808@pobox.com> <20040716194654.GA20555@redhat.com> <20040716200113.GB20555@redhat.com> <20040802221047.GA15007@kroah.com> <20040802233652.GI12724@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802233652.GI12724@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 12:36:52AM +0100, Dave Jones wrote:
> On Mon, Aug 02, 2004 at 03:10:47PM -0700, Greg KH wrote:
>  > I remember we
>  > had some "line too long" warnings that we had to fix up by hand in that
>  > file that probably didn't make it upstream.
> 
> Ah yes, I'd forgotten about those.  I'm not sure if they got fixed
> upstream or not. Holler if you spot anything odd, and I'll try my
> best to get changes to such entries approved quickly.

I had to fix up a few older ones that your patch reverted, and changed a
new one that caused errors.  Once my patch makes it to Linus (after
2.6.8 comes out) it will be pretty easy for us to see the lines that
need to get pushed back to sf.net.

thanks,

greg k-h
