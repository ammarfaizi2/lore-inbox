Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVDCE5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVDCE5L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 23:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVDCE5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 23:57:11 -0500
Received: from weber.sscnet.ucla.edu ([128.97.42.3]:62873 "EHLO
	weber.sscnet.ucla.edu") by vger.kernel.org with ESMTP
	id S261483AbVDCE5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 23:57:09 -0500
Message-ID: <424F7750.9060002@cogweb.net>
Date: Sat, 02 Apr 2005 20:55:44 -0800
From: David Liontooth <liontooth@cogweb.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ICS1883 LAN PHY not detected
References: <424EFE37.8050903@colorfullife.com>
In-Reply-To: <424EFE37.8050903@colorfullife.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

>> Gigabyte's K8NS Ultra-939 mobo has a 100/10 LAN PHY chip, ICS1883, which
>> isn't detected by the 2.6.12-rc1 kernel (and likely not previous 
>> kernels).
>
> The board is a nVidia nForce board, correct? Then please try the 
> forcedeth network driver ("Reverse Engineered nForce Ethernet support").

Works. It didn't work with the Debian Installer, and the motherboard 
manual identifies the NIC as a ICS1883, but an nforce 100/10 it is, 
taking the forcedeth driver.  Appreciate the help.

Dave
