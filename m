Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265947AbUBJRWZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266066AbUBJRTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:19:03 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:58508 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S266064AbUBJRNK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:13:10 -0500
Date: Tue, 10 Feb 2004 09:13:39 -0800
From: Mike Bell <kernel@mikebell.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040210171337.GK4421@tinyvaio.nome.ca>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210170157.GA27421@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 09:01:57AM -0800, Greg KH wrote:
> Did you read:
> 	http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs

Yes, I've read everything since the original OLS one, and liked udev
less and less with each one.

> But that is not what sysfs does.  And sysfs will not do this.  So this
> point is moot.

No, you misunderstand. I'm not suggesting that sysfs /should/ export
device files. I'm saying that sysfs exporting type/major/minor as files
is not really that different from exporting full-fledged device files.
Making udev a sort of ugly-hack devfsd.
