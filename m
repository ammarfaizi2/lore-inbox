Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWCCRH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWCCRH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 12:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWCCRH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 12:07:58 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:48365
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751343AbWCCRH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 12:07:58 -0500
Date: Fri, 3 Mar 2006 09:07:52 -0800
From: Greg KH <greg@kroah.com>
To: wixor <wixorpeek@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: using usblp with ppdev?
Message-ID: <20060303170752.GA5260@kroah.com>
References: <c43b2e150603020732m42195b0dkf33d68fe64bc4a57@mail.gmail.com> <20060302165557.GA31247@kroah.com> <c43b2e150603030512l141c101va11300bcfbda4f60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c43b2e150603030512l141c101va11300bcfbda4f60@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 02:12:46PM +0100, wixor wrote:
> >
> > Anyway, no, the usblp driver is not what you want, you probably want the
> > uss720 driver, which does register with parport.
> >
> But the problem is the uss720 driver is limited to one chip and
> doesn't see my cable! Is this chip the only one capable of doing
> direct i/o on port pins? Thanks.

What is the output of /proc/bus/usb/devices with your device plugged in?

thanks,

greg k-h
