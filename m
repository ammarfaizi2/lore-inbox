Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269468AbUJSPf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269468AbUJSPf5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 11:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269470AbUJSPf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 11:35:56 -0400
Received: from ida.rowland.org ([192.131.102.52]:3076 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S269468AbUJSPfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 11:35:50 -0400
Date: Tue, 19 Oct 2004 11:35:47 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-kernel@vger.kernel.org, Nils Rennebarth <Nils.Rennebarth@web.de>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Fw: X is killed when trying to suspend with
 USB Mouse plugged in
In-Reply-To: <200410182012.27593.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.44L0.0410191134090.1023-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004, Dmitry Torokhov wrote:

> > I don't know about /dev/input/mouse1.  But the oops isn't a bug... it's a 
> > weakness in the way Linux implements loadable kernel modules.
> > 
> 
> Ugh, it is not module implementation weakness, it looks like refcounting
> problem in USB.

Could you explain that more fully?  Are you talking about a particular 
refcounting problem in the usbhid subsystem or do you mean a more 
pervasive problem in the whole USB system?  And why do you say it's a 
refcounting problem in the first place?

Alan Stern

