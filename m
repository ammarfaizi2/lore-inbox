Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbVLUX0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbVLUX0n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbVLUX0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:26:43 -0500
Received: from styx.suse.cz ([82.119.242.94]:11756 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S964980AbVLUX0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:26:42 -0500
Date: Thu, 22 Dec 2005 00:26:45 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc5 and later: USB mouse IRQ post kills the computer post resume.
Message-ID: <20051221232645.GB9900@midnight.suse.cz>
References: <1135199640.9616.21.camel@localhost> <20051221213342.GA8315@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221213342.GA8315@kroah.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 01:33:42PM -0800, Greg KH wrote:
> On Thu, Dec 22, 2005 at 07:14:01AM +1000, Nigel Cunningham wrote:
> > Hi Vojtech.
> > 
> > I have a HT box with USB mouse support built as modules. Beginning with
> > 2.6.15-rc5 (maybe slightly earlier) a suspend/resume cycle makes the USB
> > mouse get in an invalid state, such that I get a gazillion messages in
> > the logs saying "unexpected IRQ trap at vector 99", or in some
> > alternately a hard hang. No work around found yet. Are you the right man
> > to talk to, or is Greg? (Spose I should cc him, so I'll add that now). I
> > can use kdb if it's helpful. Would you like my kconfig?
> 
> This should be taken to the linux-usb-devel list, that's the best place
> for it.
 
Indeed, it's unlikely that it's within the hid mouse driver.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
