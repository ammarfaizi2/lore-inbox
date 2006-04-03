Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWDCDgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWDCDgF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 23:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWDCDgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 23:36:05 -0400
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:37760 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932073AbWDCDgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 23:36:04 -0400
Message-ID: <44309821.1090600@triplehelix.org>
Date: Sun, 02 Apr 2006 20:36:01 -0700
From: Joshua Kwan <joshk@triplehelix.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Problems with USB setup with Linux 2.6.16
References: <Pine.LNX.4.44L0.0604022155060.29134-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0604022155060.29134-100000@netrider.rowland.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2006 07:09 PM, Alan Stern wrote:
> If you were to continue looking farther down in the log, you would find
> that ehci-hcd sees all those devices.  Those that can run at high speed
> continue using the EHCI controller.  For those that can't, the switch is 
> reset and they get reconnected to their UHCI controller.

That makes sense - that is indeed what happens when it DOES work (i.e.
with 2.6.15), but the fact is that they don't come back in 2.6.16. I
will try building ehci-hcd in and see what happens.

More in a bit, thanks for your help so far.

-- 
Joshua Kwan
