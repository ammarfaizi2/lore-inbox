Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWFUVVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWFUVVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWFUVVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:21:42 -0400
Received: from gw.goop.org ([64.81.55.164]:9615 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751393AbWFUVVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:21:42 -0400
Message-ID: <4499B86D.8010700@goop.org>
Date: Wed, 21 Jun 2006 14:21:49 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       marcel@holtmann.org, maxk@qualcomm.com, Andrew Morton <akpm@osdl.org>,
       bluez-devel@lists.sourceforge.net
Subject: Re: 2.6.17-mm1: oops in Bluetooth stuff, usbdev_open
References: <4499ADEB.1000905@goop.org> <20060621204725.GB30766@suse.de>
In-Reply-To: <20060621204725.GB30766@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Can you duplicate this without the closed source kernel module loaded?
>   
Annoyingly not.  I doubt the ath_hal module caused a problem in itself, 
but there might have been a compilation-skew with the out-of-tree 
madwifi driver.

Or its a race which only happens sometimes.  I'll keep an eye out.

    J
