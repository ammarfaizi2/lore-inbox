Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVAXPfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVAXPfC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 10:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVAXPfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 10:35:02 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:4549 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261301AbVAXPe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 10:34:58 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: gowda_avinash@emc.com
Cc: kdb@oss.sgi.com, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Announce: kdb v4.4 is available for kernel 2.6.10 
In-reply-to: Your message of "Mon, 24 Jan 2005 15:21:08 -0000."
             <50C05B7AA7D6924FB5E384EF14BC647BC451EE@inba1mx2.corp.emc.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Jan 2005 02:34:52 +1100
Message-ID: <14122.1106580892@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 15:21:08 -0000, 
gowda_avinash@emc.com wrote:
>All:
>I tried to get Kdb working on SuSe 9 ia64 box (kernel version
>2.6.5-7.111.19). Turns out that the keyboard/machine goes into a hang state.
>I have a usb keyboard!
>
>Googling around I found that Keith had disabled the USB keyboard support
>some time back due to changes in some APIs (kernel version
>linux-2.6.5-SLES9_SP1_BRANCH).
>
>Is this something that could be a cause for my problem? Should I think about
>upgrading my kernel to 2.6.10 (hoping that the issue's been fixed in this
>version)?

The USB keyboard support in KDB was written by HP, because their
systems have USB keyboards.  I have no hardware to test on, so I have
to rely on HP to keep the USB patches in KDB up to date.  That has not
happened recently.

