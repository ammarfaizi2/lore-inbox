Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264276AbUEXNbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbUEXNbV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 09:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbUEXNbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 09:31:21 -0400
Received: from ida.rowland.org ([192.131.102.52]:516 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264276AbUEXNbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 09:31:20 -0400
Date: Fri, 21 May 2004 11:05:21 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: nardelli <jnardelli@infosciences.com>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
In-Reply-To: <40AE16D6.3070202@infosciences.com>
Message-ID: <Pine.LNX.4.44L0.0405211103350.651-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2004, nardelli wrote:

> The api for usb_control_msg says, 'If successful, it returns 0, othwise a
> negative error number', and I didn't see any other way to figure out how
> much data was being returned.

In the current kernel sources, the kerneldoc for usb_control_msg() says
"If successful, it returns the number of bytes transferred, otherwise a 
negative error number."

Alan Stern

