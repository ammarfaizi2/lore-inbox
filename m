Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVBZDRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVBZDRW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 22:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVBZDRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 22:17:22 -0500
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:16810 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261181AbVBZDRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 22:17:19 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Johan Braennlund <johan_brn@yahoo.com>
Subject: Re: ALPS touchpad not seen by 2.6.11 kernels
Date: Fri, 25 Feb 2005 22:17:15 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050225222022.77009.qmail@web50203.mail.yahoo.com>
In-Reply-To: <20050225222022.77009.qmail@web50203.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502252217.16410.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 February 2005 17:20, Johan Braennlund wrote:
> 
> --- Dmitry Torokhov wrote:
> 
> > Does i8042 detect presence of an AUX port (check dmesg)? 
> 
> No.
> 
> > If not try booting with i8042.noacpi kernel boot option.
> 
> Yes, that helped - everything's working now. Thank you.
> 

Could you please send me contents of your DSDT
(cat /proc/acpi/dsdt > dsdt.hex)

Thanks!

-- 
Dmitry
