Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268025AbUJSGbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268025AbUJSGbT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 02:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268037AbUJSGbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 02:31:19 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:16516 "EHLO midnight.suse.cz")
	by vger.kernel.org with ESMTP id S268025AbUJSGbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 02:31:16 -0400
Date: Tue, 19 Oct 2004 08:30:57 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Alexandre Oliva <aoliva@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: forcing PS/2 USB emulation off
Message-ID: <20041019063057.GA3057@ucw.cz>
References: <orzn2lyw8k.fsf@livre.redhat.lsd.ic.unicamp.br> <200410172248.16571.dtor_core@ameritech.net> <20041018164539.GC18169@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041018164539.GC18169@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 09:45:39AM -0700, Greg KH wrote:

> I'm a little leary of changing the way the kernel grabs the USB hardware
> from the way we have been doing it for the past 6 years.  So by
> providing the option for people who have broken machines like these, we
> will let them work properly, and it should not affect any of the zillion
> other people out there with working hardware.
> 
> Or, if we can determine a specific model of hardware that really needs
> this option enabled, we can do that automatically.  If you look at the
> patch, we do that for some specific IBM machines for this very reason.
> 
> Is there any consistancy with the type of hardware that you see being
> reported for this issue?
 
Like 30% of all notebooks? ;) They do boot without the USB handoff, the
PS/2 mouse works, but only as a PS/2 mouse, no extended capabilities
detection is possible due to the BIOS interference.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
