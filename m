Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbVAQN6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbVAQN6X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 08:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVAQN6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 08:58:23 -0500
Received: from ns1.q-leap.de ([153.94.51.193]:15271 "EHLO mail.q-leap.de")
	by vger.kernel.org with ESMTP id S262803AbVAQN5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 08:57:32 -0500
Message-ID: <41EBC449.3090503@q-leap.com>
Date: Mon, 17 Jan 2005 14:57:29 +0100
From: Peter Kruse <pk@q-leap.com>
Organization: Q-Leap Networks GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en
MIME-Version: 1.0
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Random packets loss under x86_64 - routing?
References: <41E7E6D7.10303@q-leap.com> <Pine.LNX.4.61.0501141129260.5840@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0501141129260.5840@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

thanks for your reply

linux-os wrote:
  >
> When they 'disappear', use `arp -d hostname` to delete the
> entry from the ARP tables. Then see if you can ping it.
> It is possible that the destination machine got re-routed
> and the new router's HW address wasn't updated in the
> ARP tables. If this is the case, I don't know hot to 'fix'
> it, but it's a new data-point. When you have dynamic routing,
> there needs to be some way to update the ARP tables even though
> they eventually expire.

There is no router between sender and destination host,
they are on the same subnet and connected on the same switch.

> The fact that `ping -r` works seems to show that the ARP table
> has stale entries in it.
> 

Even directly after reboot when the arp table is empty?

	Peter

-- 
Peter Kruse <pk@q-leap.com>, Chief Software Architect
Q-Leap Networks GmbH
phone: +497071-703171, mobile: +49172-6340044
