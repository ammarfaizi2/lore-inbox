Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbUDZTmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUDZTmc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 15:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263551AbUDZTmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 15:42:32 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:11514 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261672AbUDZTmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 15:42:31 -0400
Message-ID: <408D65A7.7060207@nortelnetworks.com>
Date: Mon, 26 Apr 2004 15:40:23 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Load hid.o module synchronously?
References: <s5g8ygi4l3q.fsf@patl=users.sf.net>
In-Reply-To: <s5g8ygi4l3q.fsf@patl=users.sf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick J. LoPresti wrote:

> For example, I invoke "modprobe hid" to make my USB keyboard work.
> This loads the module and exits immediately, causing my script to
> proceed, before the USB keyboard is probed and ready.
> 
> I want to wait until the driver is finished initializing (i.e., a USB
> keyboard is either found or not found) before my script continues.
> How can I do that?

How about scanning the usb device tree to see if the keyboard is present and properly detected?

Chris
