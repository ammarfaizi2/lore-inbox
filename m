Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262762AbVBCAYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbVBCAYf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbVBCALL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 19:11:11 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:5766 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S262818AbVBCAHY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 19:07:24 -0500
Date: Wed, 2 Feb 2005 19:07:21 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@localhost.localdomain
To: Greg KH <greg@kroah.com>
cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org
Subject: Re: Please open sysfs symbols to proprietary modules
In-Reply-To: <20050202232909.GA14607@kroah.com>
Message-ID: <Pine.LNX.4.62.0502021851050.19621@localhost.localdomain>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
 <Pine.LNX.4.50.0502021520200.1538-100000@monsoon.he.net> <20050202232909.GA14607@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg and Patrick!

On Wed, 2 Feb 2005, Greg KH wrote:

> On Wed, Feb 02, 2005 at 03:23:30PM -0800, Patrick Mochel wrote:
>>
>> What is wrong with creating a (GPL'd) abstraction layer that exports
>> symbols to the proprietary modules?
>
> Ick, no!
>
> Please consult with a lawyer before trying this.  I know a lot of them
> consider doing this just as forbidden as marking your module
> MODULE_LICENSE("GPL"); when it really isn't.

There will be a GPL'd layer, and it's likely that sysfs interaction will 
be on the GPL'd side anyway, for purely technical reasons.  But it does 
feel like circumvention of the limitations set in the kernel.  I thought 
it would be polite to ask the developers to lift those limitations, 
considering that they seem unfair and inconsistent with the stated 
purpose of EXPORT_SYMBOL_GPL.

Sorry for using my gnu.org address.  I'll use my rajant.com address for 
further questions about that project.

-- 
Regards,
Pavel Roskin
