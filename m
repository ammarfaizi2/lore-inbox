Return-Path: <linux-kernel-owner+w=401wt.eu-S1751546AbXAUNCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbXAUNCr (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 08:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbXAUNCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 08:02:47 -0500
Received: from twin.jikos.cz ([213.151.79.26]:37892 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545AbXAUNCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 08:02:46 -0500
Date: Sun, 21 Jan 2007 14:01:43 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Ivan Ukhov <uvsoft@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to use an usb interface than is claimed by HID?
In-Reply-To: <45B32B80.4050208@gmail.com>
Message-ID: <Pine.LNX.4.64.0701211358570.21127@twin.jikos.cz>
References: <45B265E0.5020605@gmail.com> <Pine.LNX.4.64.0701210006591.21127@twin.jikos.cz>
 <45B2AA03.4070405@gmail.com> <Pine.LNX.4.64.0701210050490.21127@twin.jikos.cz>
 <45B32B80.4050208@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jan 2007, Ivan Ukhov wrote:

> It's a tiny driver and it hardy can be a part of the mainline kernel 
> because of its useless for everyone but me, beside I don't want to make 
> someone modify the kernel code. 

Then, when this is a non-standard situation anyway, would calling 
hid_disconnect() for the usb_interface of your driver be enough?

-- 
Jiri Kosina
