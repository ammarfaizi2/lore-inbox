Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263489AbTJCHCa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 03:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbTJCHCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 03:02:30 -0400
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:9352 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S263489AbTJCHC2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 03:02:28 -0400
Date: Fri, 3 Oct 2003 09:02:25 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test5-mm2] no /proc/bus/i2c but i2c-core module loaded +
 small oops
Message-Id: <20031003090225.5ed11211.philippe.gramoulle@mmania.com>
In-Reply-To: <20031003043325.GA16781@kroah.com>
References: <20031003043053.367eb89c.philippe.gramoulle@mmania.com>
	<20031003043325.GA16781@kroah.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.9.5claws43 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Greg,

On Thu, 2 Oct 2003 21:33:25 -0700
Greg KH <greg@kroah.com> wrote:

  | On Fri, Oct 03, 2003 at 04:30:53AM +0200, Philippe Gramoullé wrote:
  | > 
  | >  Hello,
  | > 
  | > Symptoms: modprobe i2c-core works fine but /proc/bus/i2c doesn't exist
  | 
  | /proc/bus/i2c will never exist :)

Well, ok :) No need to say that i didn't follow closely recent evolutions 
regarding i2c. I just read but documentation but obviously not for the right kernel :)
  | 
  | lmsensors has not been ported to 2.6 yet, sorry.  Look in /sys/bus/i2c
  | for the devices and sensors.

Ok Thx. Will do.
  | 
  | > Device class 'i2c-0' does not have a release() function, it is broken and must be fixed.
  | > Badness in class_dev_release at drivers/base/class.c:200
  | 
  | bah, forget to fix this one up.  Will get to it in the next few days.

Ok. Hope that it helped.

  | 
  | thanks,

Thanks to you.

  | 
  | greg k-h

Bye,

Philippe
