Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264144AbUDGTEG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 15:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbUDGTEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 15:04:06 -0400
Received: from mail.kroah.org ([65.200.24.183]:10402 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264144AbUDGTEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 15:04:04 -0400
Date: Wed, 7 Apr 2004 11:21:01 -0700
From: Greg KH <greg@kroah.com>
To: Fabian Frederick <Fabian.Frederick@skynet.be>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.5rc2-mm2] Root_plug device check
Message-ID: <20040407182100.GB20173@kroah.com>
References: <1080981753.4309.26.camel@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080981753.4309.26.camel@linux.local>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2004 at 10:42:33AM +0200, Fabian Frederick wrote:
> Hi,
> 
>       Here's a patch to check device in root_plug to avoid box freeze
> when user gives bad ids.

No, this patch is not acceptable.  It's fine if the USB device is not
present when the module is loaded, any future programs run as root will
just not run.

So the current behavior is correct.

thanks,

greg k-h
