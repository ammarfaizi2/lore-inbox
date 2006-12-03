Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759900AbWLCWnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759900AbWLCWnO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 17:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760139AbWLCWnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 17:43:14 -0500
Received: from dvhart.com ([64.146.134.43]:2198 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1759900AbWLCWnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 17:43:13 -0500
Message-ID: <45735230.7030504@mbligh.org>
Date: Sun, 03 Dec 2006 14:39:44 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: Device naming randomness (udev?)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This PC has 1 ethernet interface, an e1000. Ubuntu Dapper.

On 2.6.14, my e1000 interface appears as eth0.
On 2.6.15 to 2.6.18, my e1000 interface appears as eth1.

In both cases, there are no other ethX interfaces listed in
"ifconfig -a". There are no modules involved, just a static
kernel build.

Is this a bug in udev, or the kernel? I'm presuming udev,
but seems odd it changes over a kernel release boundary.
Any ideas on how I get rid of it? Makes automatic switching
between kernel versions a royal pain in the ass.

M.
