Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbVBCAOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbVBCAOA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVBCAKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 19:10:35 -0500
Received: from kludge.physics.uiowa.edu ([128.255.33.129]:14093 "EHLO
	kludge.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S262581AbVBCAJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 19:09:46 -0500
Date: Wed, 2 Feb 2005 18:09:17 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Please open sysfs symbols to proprietary modules
Message-ID: <20050203000917.GA12204@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Pavel Roskin <proski@gnu.org>,
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
	Patrick Mochel <mochel@digitalimplant.org>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Pavel Roskin on Wednesday, 02 February, 2005:
>All I want to do is to have a module that would create subdirectories for 
>some network interfaces under /sys/class/net/*/, which would contain 
>additional parameters for those interfaces.  I'm not creating a new 
>subsystem or anything like that.  sysctl is not good because the data is 
>interface specific.  ioctl on a socket would be OK, although it wouldn't 
>be easily scriptable.  The restriction on sysfs symbols would just force 
>me to write a proprietary userspace utility to set those parameters 
>instead of using a shell script.

Please pardon my ignorance, but if the existing network device management
  framework is insufficient, it seems that the optimal way to deal with
  this is to work with the community to address the insufficiencies, not
  hacking in a new interface to the device.

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
      Graduate Student in Physics, Freelance Free Software Developer
