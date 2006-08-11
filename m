Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWHKPX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWHKPX3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 11:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWHKPX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 11:23:29 -0400
Received: from elvira.its.UU.SE ([130.238.164.5]:34731 "EHLO elvira.its.uu.se")
	by vger.kernel.org with ESMTP id S1751187AbWHKPX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 11:23:28 -0400
Message-ID: <44DCA0E4.2000804@lanil.mine.nu>
Date: Fri, 11 Aug 2006 17:23:16 +0200
From: Christian Axelsson <smiler@lanil.mine.nu>
User-Agent: Thunderbird 1.5.0.5 (X11/20060804)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] USB x-pad problems
References: <Pine.LNX.4.44L0.0608091341370.7248-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0608091341370.7248-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> On Wed, 9 Aug 2006, Christian Axelsson wrote:
> 
>> Alan Stern wrote:
>>> From your log, it looks like the computer has trouble communicating with 
>>> the external hub.  What happens if you plug the X-box dancepad directly 
>>> into the computer, bypassing the hub?
>>  From what I know this is directly into my computer (directly into the 
>> motherboard atleast :P).
> 
> I guess the hub is built directly into the X-pad.
> 
> This may or may not help...  If you build a kernel with CONFIG_USB_DEBUG 
> set, the dmesg log will then contain more detailed information about what 
> happens when you plug in the X-pad.

Said and done. The result, snipped from my kern.log (dmesg buffer got 
flooded) is attached... I dont really know what to make out of it except 
that it seems to verify that it the pad has it's own hub.

-- 
Christian
