Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264001AbUDFUvJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264006AbUDFUvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:51:09 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:54544 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264001AbUDFUvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:51:06 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Soeren Sonnenburg <kernel@nn7.de>, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: regression: oops with usb bcm203x bluetooth dongle 2.6.5
Date: Tue, 6 Apr 2004 23:50:54 +0300
User-Agent: KMail/1.5.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1081196482.3591.5.camel@localhost> <1081207065.17215.6.camel@pegasus> <1081235549.2050.3.camel@localhost>
In-Reply-To: <1081235549.2050.3.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404062350.54987.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 April 2004 10:12, Soeren Sonnenburg wrote:
> On Tue, 2004-04-06 at 01:17, Marcel Holtmann wrote:
>
> Hello Marcel,
>
> forget about the while [] change in the hotplug firmware script. It still
> oopses :(
>
> I was even able to cause the very same oops when I used
> /sbin/bluefw.inactive to load the firmware !

If you feeling desperate, go back to 2.6.3,
verify that it works, and start binary search
in [2.6.3, 2.6.5] range. 
--
vda

