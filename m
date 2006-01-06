Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751599AbWAFQMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbWAFQMI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWAFQMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:12:07 -0500
Received: from smtp.seznam.cz ([212.80.76.43]:11605 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S1751545AbWAFQMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:12:06 -0500
Message-ID: <43BE96DA.1020107@seznam.cz>
Date: Fri, 06 Jan 2006 17:12:10 +0100
From: Feyd <feyd@seznam.cz>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Buesch <mbuesch@freenet.de>
CC: Marcel Holtmann <marcel@holtmann.org>, jgarzik@pobox.com,
       bcm43xx-dev@lists.berlios.de, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Bcm43xx-dev] [Fwd: State of the Union: Wireless]
References: <1136541243.4037.18.camel@localhost> <200601061200.59376.mbuesch@freenet.de> <1136547494.7429.72.camel@localhost> <200601061245.55978.mbuesch@freenet.de>
In-Reply-To: <200601061245.55978.mbuesch@freenet.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> The _real_ main point I wanted to make was to _not_ use a net_device for
> the master device. What else should be used for master device, let it
> be a device node or a netlink socket, is rather unimportant at
> this stage.

If the only purpose of the master device was configuration, then it
would be beter to use something other then a net_device, but you may
want to send/receive raw 802.11 packets from userspace, most logicaly
over a master interface.

Feyd

