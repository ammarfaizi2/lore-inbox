Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbTECAjG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 20:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263220AbTECAjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 20:39:06 -0400
Received: from granite.he.net ([216.218.226.66]:27665 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263219AbTECAjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 20:39:05 -0400
Date: Fri, 2 May 2003 17:38:37 -0700
From: Greg KH <greg@kroah.com>
To: Balram Adlakha <b_adlakha@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wrong screen size with fbcon [2.5.68]
Message-ID: <20030503003836.GA1071@kroah.com>
References: <20030502230637.GA494@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030502230637.GA494@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 03, 2003 at 04:36:37AM +0530, Balram Adlakha wrote:
> I posted about this when 2.5.68 was released but very few people 
> responded.
> While using the framebuffer console driver, I seems that the screen is 
> set to something like 1024x775 instead of 1024x768. I cannot see the 
> bottom of my screen that is...
> I just checked the latest bk taken from kernel.org and still hasn't been 
> fixed.
> The fb console was working perfectly till 2.5.67.
> 
> If it is of any relevance, I'm using an nvidia tnt2 card. Has nobody 
> noticed this problem?

I have, and posted pretty much the same report a few weeks ago.  Time to
go write up a bug in bugzilla.kernel.org...

greg k-h
