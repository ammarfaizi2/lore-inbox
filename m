Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267761AbUBRSec (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 13:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267786AbUBRSec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 13:34:32 -0500
Received: from [24.78.220.246] ([24.78.220.246]:49823 "EHLO mail.thock.com")
	by vger.kernel.org with ESMTP id S267783AbUBRSeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 13:34:31 -0500
Message-ID: <4033B0E0.9080805@thock.com>
Date: Wed, 18 Feb 2004 12:37:20 -0600
From: Dylan Griffiths <dylang+kernel@thock.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Updated HFSplus driver for 2.6.3.
References: <402304F0.1070008@thock.com> <20040205191527.4c7a488e.akpm@osdl.org>
In-Reply-To: <20040205191527.4c7a488e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I've updated the Linux HFS+ driver to a simple, easy to apply patch to 
your fresh 2.6.3 kernel; just go into file systems, and turn on HFSPlus 
(it's right below HFS).  You do need EXPERIMENTAL turned on to compile 
it.  I've tested it working on x86 for firewire access to an HFS+ 
formattted iPod.  Naturally, I welcome further testing by a wider 
selection of hardware combinations :)

The patch can be found here:
http://inoshiro.com/devel/linux-2.6.3-hfsplus.patch.gz
