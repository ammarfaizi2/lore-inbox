Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVAOD5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVAOD5v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 22:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVAOD5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 22:57:51 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:33706 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262109AbVAOD5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 22:57:45 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org,
       Matthew Harrell 
	<mharrell-dated-1106189901.f84b08@bittwiddlers.com>
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Date: Fri, 14 Jan 2005 22:57:43 -0500
User-Agent: KMail/1.6.2
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org> <200501142031.10119.dtor_core@ameritech.net> <20050115025818.GA28422@bittwiddlers.com>
In-Reply-To: <20050115025818.GA28422@bittwiddlers.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501142257.43256.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 January 2005 09:58 pm, Matthew Harrell wrote:
> : Also, there is a patch my Alan Cox dealing with legacy emulation (but note
> : that first part (udelay(50)) has already been applied:
> : 
> : http://marc.theaimsgroup.com/?l=linux-kernel&m=109096903809223&q=raw
> 
> Well acpipnp didn't have any effect.
> 
> I tried the patch above but there's an undefined function, pci_find_class,
> in i8042_spank_usb.  Did it change names?
> 

I think it supposed to be pci_get_class now.

You might want to ask on ACPI list if they have any idea why i8042 is
dead with ACPI activated.

-- 
Dmitry
