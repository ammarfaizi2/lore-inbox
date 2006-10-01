Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWJASgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWJASgf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 14:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWJASge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 14:36:34 -0400
Received: from mout0.freenet.de ([194.97.50.131]:44742 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1750806AbWJASgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 14:36:33 -0400
Date: Sun, 01 Oct 2006 20:37:24 +0200
To: "Peter Osterlund" <petero2@telia.com>
Subject: Re: [PATCH 2.6.18] pktcdvd driver module: added sysfs interface
Reply-To: balagi@justmail.de
From: "Thomas Maier" <balagi@justmail.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-15
MIME-Version: 1.0
References: <op.tgd9kamfiudtyh@master> <op.tgqhg1pgiudtyh@master> <m3d59ci4n5.fsf@telia.com>
Content-Transfer-Encoding: 7bit
Message-ID: <op.tgq8k7j9iudtyh@master>
In-Reply-To: <m3d59ci4n5.fsf@telia.com>
User-Agent: Opera Mail/9.00 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> "Thomas Maier" <balagi@justmail.de> writes:
>
>> this is a patch for the packet writing module pktcdvd.
>> The patch adds a sysfs and a debugfs interface, a Kconfig
>> parameter to switch of the procfs interface off and a
>> bio write queue congestion handling for the driver.
>
> I think most of these changes are good. However, some comments:
>
> * There are many logically independent parts in this change, so they
>   should be in separate patches. For example:
>   - Introduce the DRIVER_NAME #define.
>   - Add sysfs support.
>   - Make procfs support optional.
>   - Implement congestion control.
>   - Move lots of functions around. (Is it needed at all?)

Oh, this is ugly for coding, since all is in the same file.
But i splitted the patch and will send all 4 parts again.

I moved the functions for grouping and better readability.


> * You need to add Signed-off-by.

Ok.

> * You should CC Andrew Morton and not Linus. These changes should live
>   in -mm for a while before going into the main tree.

Ok, but the changes should not be harmful and easy, i think ;)

> * The patch is white space damaged. All lines that should start with a
>   single space start with two spaces.

Ugly. Thanks for the hit, haven't noticed it.


Thanks

Thomas Maier

