Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbVAUUaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVAUUaF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 15:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbVAUUaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 15:30:04 -0500
Received: from animx.eu.org ([216.98.75.249]:10643 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262501AbVAUU3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 15:29:18 -0500
Date: Fri, 21 Jan 2005 15:39:38 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: md and RAID 5 [was Re: LVM2]
Message-ID: <20050121203938.GB25934@animx.eu.org>
Mail-Followup-To: "Trever L. Adams" <tadams-lists@myrealbox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1106250687.3413.6.camel@localhost.localdomain> <1106336028.3369.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106336028.3369.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trever L. Adams wrote:
> Thank you all for having been so kind in your responses and help.
> 
> However, there is one more set of questions I have.
> 
> Does the md (software raid) have disk size or raid volume limits?
> 
> If I am using such things as USB or 1394 disks, is there a way to use
> labels in /etc/raidtab and with the tools so that when the disks, if
> they do, get renumbered in /dev that all works fine. I am aware that the
> kernel will autodetect these devices, but that the raidtab needs to be
> consistent. This is what I am trying to figure out how to do.

EVMS can handle this for you.  I've used it with a raid set I made with some
of the drives being on usb and some on ide.

If you use evms, you might want to consider the activation after all disks
have been discovered.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
