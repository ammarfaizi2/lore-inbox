Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVAYXm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVAYXm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 18:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVAYXlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:41:00 -0500
Received: from mail1.skjellin.no ([80.239.42.67]:10687 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S262219AbVAYXVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:21:33 -0500
Message-ID: <41F6D475.2080008@tomt.net>
Date: Wed, 26 Jan 2005 00:21:25 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050122)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jasper@Morgana.NET
Cc: linux-kernel@vger.kernel.org
Subject: Re: Drive missing only with LVM kernel
References: <1106685009.8968.15.camel@localhost>
In-Reply-To: <1106685009.8968.15.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jasper Koolhaas wrote:
> As soon as the system had booted hdg has completely vanished, even in
> single user mode:
> 
> # ls /dev/hd* /dev/sd*
> /dev/hda   /dev/hda3  /dev/hdc1  /dev/hde   /dev/hde3  /dev/sda2  /dev/sdb1
> /dev/hda1  /dev/hda4  /dev/hdc2  /dev/hde1  /dev/sda   /dev/sda3  /dev/sdb2
> /dev/hda2  /dev/hdc   /dev/hdc3  /dev/hde2  /dev/sda1  /dev/sdb   /dev/sdb3
> 
> But the RAID is working just fine:

cd /dev && ./MAKEDEV hdg

In normal operation md-raid adresses the drive "internally", not via /dev.
