Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbUAAUzb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUAAUzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:55:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:27285 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264934AbUAAUDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:03:48 -0500
Date: Thu, 1 Jan 2004 12:03:49 -0800
From: Greg KH <greg@kroah.com>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040101200349.GE17233@kroah.com>
References: <20031231192306.GG25389@kroah.com> <Pine.LNX.4.44.0401011714460.934-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401011714460.934-100000@neptune.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 05:17:50PM +0100, Pascal Schmidt wrote:
> On Wed, 31 Dec 2003, Greg KH wrote:
> 
> > You would not have any "extra" overhead if you don't add any new devices
> > to your system.  udev only runs when /sbin/hotplug runs. As for extra
> > space on your disk, this email thread is almost as big as the udev
> > binary is :)
> 
> Well, but if random device numbers become a reality, udev would have
> to run at boot time or I wouldn't get usable device nodes.

Exactly, it's on the TODO list :)

thanks,

greg k-h
