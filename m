Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVBKBQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVBKBQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 20:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVBKBQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 20:16:28 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:64803 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261994AbVBKBQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 20:16:25 -0500
Date: Thu, 10 Feb 2005 17:16:09 -0800
From: Greg KH <gregkh@suse.de>
To: Patrick McFarland <pmcfarland@downeast.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Message-ID: <20050211011609.GA27176@suse.de>
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420C054B.1070502@downeast.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 08:07:23PM -0500, Patrick McFarland wrote:
> 
> Please, continue this project and encourage distros to switch to it (when 
> it exceeds hotplug in functionality and stability). Ubuntu currently is 
> trying to reduce boot time, and I bet something like this would factor in 
> (even a few seconds helps).

Thanks for the kind words.

All distros are trying to reduce boot time.  I don't think that the
module autoload time has been fingered as taking any serious ammount of
boot time due to it happening in the background of everything else.  But
yes, this should help it out (as long as we aren't trading I/O time for
CPU time, like it can happen if you don't have a populated modules.alias
file...)

And yes, I've been in contact with the Ubuntu developer already about
using this code, instead of dietHotplug.

thanks,

greg k-h
