Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUCATLA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 14:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUCATLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 14:11:00 -0500
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:36741 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S261405AbUCATK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 14:10:58 -0500
Message-ID: <40438CDB.9080003@am.sony.com>
Date: Mon, 01 Mar 2004 11:19:55 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: FASTBOOT options in EMBEDDED menu?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm starting to adapt some patches for options which
allow Linux to boot faster (for embedded environments).

It seems like these should go under the EMBEDDED
menu.  However, this menu looks like it is specific
to size reductions:

menuconfig EMBEDDED
     bool "Remove kernel features (for embedded systems)"
     help
       This option allows certain base kernel features to be removed from
       the build...

Some of the options that CELF is working on for
fast booting do remove features, but some do not.

Anyone have advice for whether I should:
1) use the existing EMBEDDED option (my preference), or
2) make a new FASTBOOT option?

Thanks.

=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics


