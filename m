Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262609AbRFGOaz>; Thu, 7 Jun 2001 10:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262615AbRFGOaq>; Thu, 7 Jun 2001 10:30:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28426 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262609AbRFGOad>;
	Thu, 7 Jun 2001 10:30:33 -0400
Date: Thu, 7 Jun 2001 15:28:36 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: bohdan@kivc.vstu.vinnica.ua,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: isolating process..
Message-ID: <20010607152836.B1765@flint.arm.linux.org.uk>
In-Reply-To: <200106071340.IAA59373@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106071340.IAA59373@tomcat.admin.navo.hpc.mil>; from pollard@tomcat.admin.navo.hpc.mil on Thu, Jun 07, 2001 at 08:40:06AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2001 at 08:40:06AM -0500, Jesse Pollard wrote:
> ---------  Received message begins Here  ---------
> > Byt how should I restrict him open socket and send some data (my IP,
> > for example) somewhere ??

I believe that Netfilter will do this for you.  Look at:

Owner match support (EXPERIMENTAL)
CONFIG_IP_NF_MATCH_OWNER
  Packet owner matching allows you to match locally-generated packets
  based on who created them: the user, group, process or session.

  If you want to compile it as a module, say M here and read
  Documentation/modules.txt.  If unsure, say `N'.


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

