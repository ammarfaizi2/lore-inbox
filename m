Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266111AbTIKARU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 20:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbTIKARU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 20:17:20 -0400
Received: from mail5.intermedia.net ([206.40.48.155]:28677 "EHLO
	mail5.intermedia.net") by vger.kernel.org with ESMTP
	id S266111AbTIKARR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 20:17:17 -0400
Subject: Re: [OOPS] Linux-2.6.0-test5-bk
From: Ranjeet Shetye <ranjeet.shetye2@zultys.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030910232511.GA6422@kroah.com>
References: <1063232210.4441.14.camel@ranjeet-pc2.zultys.com>
	 <20030910232511.GA6422@kroah.com>
Content-Type: text/plain
Organization: Zultys Technologies Inc.
Message-Id: <1063239639.1327.25.camel@ranjeet-pc2.zultys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 10 Sep 2003 17:20:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-10 at 16:25, Greg KH wrote:
> On Wed, Sep 10, 2003 at 03:16:50PM -0700, Ranjeet Shetye wrote:
> > 
> > file: oops4.ksyms.txt: the OOPS that I got.
> > file: oops4.bt.txt: ksymoops-derived backtrace of OOPS.
> > file: .config - my .config file.
> > 
> > To verify that this is not a compilation problem, I ran a 'make
> > mrproper' and compiled from scratch.
> > 
> > Something to note: module support is disabled and I remember that
> > sometime back you needed to have ALSA compiled as a module, and this
> > OOPS is in ALSA. Is it still necessary to compile ALSA as a module ?
> > 
> > I am not on the kernel mailing list, (only on linux-net and netdev). So
> > please email me personally if you need any other information.
> 
> What were you doing that caused this oops?
> 
> thanks,
> 
> greg k-h

Hi Greg,

The OOPS was happening at boot time. Andrew's fix has resolved the
issue.

thanks,
Ranjeet.
-- 

Ranjeet Shetye
Senior Software Engineer
Zultys Technologies
Ranjeet dot Shetye2 at Zultys dot com
http://www.zultys.com/
 
The views, opinions, and judgements expressed in this message are solely
those of the author. The message contents have not been reviewed or
approved by Zultys.


