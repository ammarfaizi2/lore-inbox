Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTGAVWx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 17:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTGAVWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 17:22:53 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:20179 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263848AbTGAVWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 17:22:50 -0400
Date: Tue, 1 Jul 2003 13:53:41 -0700
From: Greg KH <greg@kroah.com>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 USB oops
Message-ID: <20030701205341.GA840@kroah.com>
References: <m2smpu73du.fsf@tnuctip.rychter.com> <20030628164748.GB1619@kroah.com> <m2brwg1vnr.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2brwg1vnr.fsf@tnuctip.rychter.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29, 2003 at 01:22:16PM -0700, Jan Rychter wrote:
> >>>>> "Greg" == Greg KH <greg@kroah.com> writes:
>  Greg> On Sat, Jun 28, 2003 at 06:11:57AM -0700, Jan Rychter wrote:
>  >> I got the following oops after doing "modprobe uhci". The system
>  >> froze completely about 30 seconds after that.
>  >>
>  >> Before that, I have unloaded uhci, loaded usb-uhci, and then
>  >> unloaded usb-uhci again. This could be relevant.
> 
>  Greg> So if you just load the uhci driver everything works?  Did you
>  Greg> have any usb devices connected?
> 
> Yes, I normally use uhci and do not have any problems. I might have had
> a device connected (a bluetooth USB adapter), but I am not sure now.
> 
> Should I try to reproduce this, or is the trace sufficient?

Yes, try to reproduce this, then let the people at linux-usb-devel know
about it.

thanks,

greg k-h
