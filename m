Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbUKIXrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbUKIXrj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbUKIXpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:45:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:14782 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261768AbUKIXo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:44:56 -0500
Date: Tue, 9 Nov 2004 15:44:18 -0800
From: Greg KH <greg@kroah.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: dtor_core@ameritech.net, Kay Sievers <kay.sievers@vrfy.org>,
       linux-kernel@vger.kernel.org
Subject: Re: /sys/devices/system/timer registered twice
Message-ID: <20041109234417.GA8313@kroah.com>
References: <88056F38E9E48644A0F562A38C64FB60034D6F9F@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60034D6F9F@scsmsx403.amr.corp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 03:41:51PM -0800, Pallipadi, Venkatesh wrote:
> 
> But, do we really need two system devices for timers?. I feel 
> we can call setup_pit_timer from time.c, whenever pit is being used.
> Otherwise, we may have more issues like the order in which these 
> two resumes are called and the like.

I have no idea.  Why not work this out with the other system device
authors, as it's obvious people will have both of them loaded at the
same time.

thanks,

greg k-h
