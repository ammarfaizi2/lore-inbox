Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264920AbTLaOHn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 09:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbTLaOHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 09:07:43 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:50674 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S264920AbTLaOHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 09:07:42 -0500
Date: Wed, 31 Dec 2003 09:14:06 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: David Ford <david+hb@blue-labs.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: APCUPSD and HID spam
Message-ID: <20031231091406.A22231@mail.kroptech.com>
References: <3FF257A0.8070906@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FF257A0.8070906@blue-labs.org>; from david+hb@blue-labs.org on Tue, Dec 30, 2003 at 11:59:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 11:59:12PM -0500, David Ford wrote:
> after starting apcupsd, my system is deluged with over three thousand of 
> these messages per second; the control queue full messages.  doesn't 
> stop until apcupsd is stopped.  i can't say if this is new or longtime, 
> i just hooked it up after several months.

<snip>

> Dec 30 23:42:09 Huntington-Beach drivers/usb/input/hid-core.c: control 
> queue full

Known bug. Upgrade apcupsd to 3.10.8 or the kernel to 2.6.1-rc1.

FYI, in the future you should direct inquiries regarding apcupsd to the
apcupsd-users list (apcupsd-users@lists.sourceforge.net) and search its
archive where bugs such as this tend to be well known.

--Adam

