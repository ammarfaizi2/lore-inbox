Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbTJRTOx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 15:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbTJRTOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 15:14:53 -0400
Received: from zork.zork.net ([64.81.246.102]:58756 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261776AbTJRTOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 15:14:52 -0400
To: "Thomas Giese" <Thomas.Giese@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: X crashes under linux-2.6.0-test7-mm1
References: <003b01c395a8$22dbf270$fb457dc0@tgasterix>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: "Thomas Giese" <Thomas.Giese@gmx.de>,
 <linux-kernel@vger.kernel.org>
Date: Sat, 18 Oct 2003 20:14:47 +0100
In-Reply-To: <003b01c395a8$22dbf270$fb457dc0@tgasterix> (Thomas Giese's
 message of "Sat, 18 Oct 2003 20:46:26 +0200")
Message-ID: <6uy8viz7bs.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas Giese" <Thomas.Giese@gmx.de> writes:

> changed the kernel from 2.4.4 to 2.6.0-test7-mm1 i got the following
> messages after starting X11:  http://www.tgsoftware.de/xfree.txt

It looks like you have forgotten to configure agpgart.

You need to set

CONFIG_AGP=y
CONFIG_AGP_INTEL=y

