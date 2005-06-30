Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262734AbVF3RW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbVF3RW4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 13:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVF3RW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 13:22:56 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:44443 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S262734AbVF3RWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 13:22:54 -0400
Message-ID: <34128.127.0.0.1.1120152169.squirrel@localhost>
In-Reply-To: <20050630060206.GA23321@kroah.com>
References: <20050630060206.GA23321@kroah.com>
Date: Thu, 30 Jun 2005 12:22:49 -0500 (CDT)
Subject: Re: [GIT PATCH] Driver core patches for 2.6.13-rc1
From: "John Lenz" <lenz@cs.wisc.edu>
To: "Greg KH" <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, June 30, 2005 1:02 am, Greg KH said:
> Here are some small patches for the driver core.  They fix a bug that
> has caused some people to see deadlocks when some drivers are unloaded
> (like ieee1394), and add the ability to bind and unbind drivers from
> devices from userspace (something that people have been asking for for a
> long time.)

As long as there are a whole bunch of class API changes going on, I would
request that the class_interface add and remove functions get passed the
class_interface pointer as well as the class_device.  This way, the same
function can be used on multiple class_interfaces.

John

