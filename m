Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261318AbSJYIkP>; Fri, 25 Oct 2002 04:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261319AbSJYIkO>; Fri, 25 Oct 2002 04:40:14 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:38625 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261318AbSJYIjt>; Fri, 25 Oct 2002 04:39:49 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org
Subject: Re: USB does not work after 2.4.18 to 2.5.44-ac2 upgrade
Date: Fri, 25 Oct 2002 10:45:57 +0200
User-Agent: KMail/1.4.7
References: <20021025024906.GA18214@ncsu.edu>
In-Reply-To: <20021025024906.GA18214@ncsu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200210251045.57009.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 October 2002 04:49, jlnance@unity.ncsu.edu wrote:
> Hello All,
>     I decided to do what Linus asked, and try out a 2.5.X kernel.
> The machine boots fine with the 2.5.44-ac2 kernel I installed, however
> I am having some problems with USB.  The usb-uhci module seems to be
> gone.  I read Documentation/usb/uhci.txt and it appears that the
> uhci module has been rewritten.  I assume the module named uhci-hcd.o
> is the replacement, but I could not find that written down anywhere.
> I did an insmod of this module and I can now see the hub in
> /proc/bus/usb/devices.  I dont see any of my other USB devices in that
> file, even after I insmod the drivers.  Does anyone know what I need to
> do to make this all work, preferably in a way that will let me boot into
> a 2.4 kernel as well?

The latest hotplug scripts know about the new and old names and modprobe
them appropriately.  Maybe that will help.

Duncan.
