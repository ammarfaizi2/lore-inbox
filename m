Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270779AbUJUSCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270779AbUJUSCM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270773AbUJUR6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:58:00 -0400
Received: from [66.35.79.110] ([66.35.79.110]:20146 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S270711AbUJURyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 13:54:09 -0400
Date: Thu, 21 Oct 2004 10:53:44 -0700
From: Tim Hockin <thockin@hockin.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Alexandre Oliva <aoliva@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: forcing PS/2 USB emulation off
Message-ID: <20041021175344.GA1837@hockin.org>
References: <orzn2lyw8k.fsf@livre.redhat.lsd.ic.unicamp.br> <200410172248.16571.dtor_core@ameritech.net> <20041018164539.GC18169@kroah.com> <20041019063057.GA3057@ucw.cz> <1098302200.12374.44.camel@localhost.localdomain> <20041021062103.GA1252@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021062103.GA1252@ucw.cz>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 08:21:03AM +0200, Vojtech Pavlik wrote:
> And I would be fine to move the atkbd/psmouse initialization down in the
> Makefiles so that USB gets initialized first - but what do we do about
> the modular case? 
> 
> I do agree that we should have only one copy of the handoff code,
> regardless of where it's living.

I just wanted to pipe up and say that I'm being hit by this same bug this
week.  Except in my case, the system sometimes blows up and reboots during
kb probing (2.4.x kernel).  I've not tried 2.6 on this box yet.

I don't know what the right answer is yet, but it sure is frustrating.
