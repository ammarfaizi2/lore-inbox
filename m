Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVBQSHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVBQSHc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 13:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVBQSHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 13:07:32 -0500
Received: from mail.suse.de ([195.135.220.2]:63440 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261170AbVBQSH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 13:07:29 -0500
Date: Thu, 17 Feb 2005 19:07:28 +0100
From: Olaf Hering <olh@suse.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PHYSDEVDRIVER=<NULL>
Message-ID: <20050217180728.GA6854@suse.de>
References: <20050217140858.GA32212@suse.de> <20050217173100.GA10786@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050217173100.GA10786@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Feb 17, Greg KH wrote:

> On Thu, Feb 17, 2005 at 03:08:58PM +0100, Olaf Hering wrote:
> > 
> > For some reasons, PHYSDEVDRIVER can be <NULL> for block events.
> > So just check for that.
> 
> That's odd.  Any idea what driver causes this?  A bus should always have
> a name associated with it.  I'd rather fix the broken bus driver.

I dont know what driver caused this, its one of these weird intel
laptops.
But I fixed it in userland by quoting the enviroment variables.
