Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbTIOD7n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 23:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbTIOD7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 23:59:43 -0400
Received: from main.gmane.org ([80.91.224.249]:16570 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262433AbTIOD7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 23:59:42 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: [CONFIG] zlib decompression not selectable
Date: Mon, 15 Sep 2003 05:54:23 +0200
Message-ID: <bk3dfb$g45$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030906
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my problem is simple:
i have both kernel 2.4.21 and 2.4.22 and want to include "zlib 
decompression support". With "make menuconfig" i don't even see that 
option under "Library Routines" - with "make xconfig" i see it, but it 
disabled.

Na matter what i do, in the .config it always says
   CONFIG_ZLIB_INFLATE=m
which is not what i want. I can set it to "y" but as soon as i start 
xconfig or menuconfig and save the config again, it is reset to "m".

So what am i doing wrong here? Is this a bug in the config-stuff?


