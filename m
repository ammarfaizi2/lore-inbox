Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbTDKXS7 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbTDKXS7 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:18:59 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:36089 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262406AbTDKXS4 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 19:18:56 -0400
Date: Fri, 11 Apr 2003 16:32:48 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: David Lang <david.lang@digitalinsight.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Jeremy Jackson'" <jerj@coplanar.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-hotplug-devel@lists.sourceforge.net'" 
	<linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411233248.GB4539@kroah.com>
References: <A46BBDB345A7D5118EC90002A5072C780BEBAA44@orsmsx116.jf.intel.com> <Pine.LNX.4.44.0304111347370.8422-100000@dlang.diginsite.com> <20030411205948.GV1821@kroah.com> <3E974299.3030701@mvista.com> <20030411225137.GB3786@kroah.com> <3E974F68.5020106@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E974F68.5020106@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 04:27:36PM -0700, Steven Dake wrote:
> Hmm, I thought you were creating a tmpfs in /dev.  I think that 
> particular case would allow dnotify to tell you when permissions and 
> owners changed?

My bad, you are correct.  Sorry, got confused there.

Hm, does dnotify show events on a ramfs or tmpfs partition?  Haven't
tried that out before.

thanks,

greg k-h
