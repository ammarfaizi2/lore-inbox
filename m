Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266167AbUBJUll (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 15:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUBJUlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 15:41:40 -0500
Received: from smtp.terra.es ([213.4.129.129]:24875 "EHLO tsmtp12.mail.isp")
	by vger.kernel.org with ESMTP id S266167AbUBJUlj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 15:41:39 -0500
Date: Tue, 10 Feb 2004 21:32:36 +0100
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-Id: <20040210213236.2f211677.diegocg@teleline.es>
In-Reply-To: <40293508.1040803@nortelnetworks.com>
References: <20040210113417.GD4421@tinyvaio.nome.ca>
	<20040210170157.GA27421@kroah.com>
	<20040210171337.GK4421@tinyvaio.nome.ca>
	<40291A73.7050503@nortelnetworks.com>
	<20040210192456.GB4814@tinyvaio.nome.ca>
	<40293508.1040803@nortelnetworks.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 10 Feb 2004 14:46:16 -0500 Chris Friesen <cfriesen@nortelnetworks.com> escribió:

> Mike Bell wrote:
> 
> > Why does it make management easier to have no predictable name for a
> > device?
> 
> I believe this is a misconception.
> 
> Udev uses standard rules by default.  If the end-user (or their distro) 
> wants to add additional rules or override these rules, they can do that.

It even communicate the addition/removal of devices to userspace applications
through DBUS (freedesktop.org standard that will be adopted by kde,
gnome, etc - ie: useful stuff). So you don't even need to know the device names: 
the application will receive the notificacion.

Of course, this is doable with devfs. But it's been done already, in a
*much* cleaner way, with udev. So why bother, I wonder...


