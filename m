Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTIECwg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 22:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTIECwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 22:52:36 -0400
Received: from main.gmane.org ([80.91.224.249]:21481 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261754AbTIECwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 22:52:35 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Charles Lepple <clepple@ghz.cc>
Subject: Re: PROBLEM: blank boot screen on linux-2.6.0-test4 (with workaround)
Date: Thu, 04 Sep 2003 22:52:42 -0400
Message-ID: <bj8tpg$28f$1@sea.gmane.org>
References: <005e01c37105$1bddc600$323be90c@bananacabana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
In-Reply-To: <005e01c37105$1bddc600$323be90c@bananacabana>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Peterson wrote:
> Why does "vga=773" work with linux-2.4.20, but not linux-2.60-test4? Why
> does linux-2.6.0-test4 require "video=vga16:off", but linux-2.4.20 does not?

IIRC, 'vga=' parameters > 256 are handled by the VESA driver.

Try posting both .config files if enabling CONFIG_FB_VESA doesn't work 
with vga=773.

-C


