Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWEVPkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWEVPkZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 11:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWEVPkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 11:40:25 -0400
Received: from smtp-out.google.com ([216.239.45.12]:60981 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750705AbWEVPkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 11:40:24 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
	b=AfebX/tVOObpHPulJmh5RCBMudEicIgTAnykvo1lv1nL+02kCRsS0cjUICopC+rI2
	yNkgY6jwTwbEwVxvv7kjQ==
Message-ID: <4471DB32.9060708@google.com>
Date: Mon, 22 May 2006 08:39:30 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List a <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: 2.6.17-rc4-mm3 - Build error in jffs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://test.kernel.org/abat/32863/debug/test.log.0

fs/jffs2/scan.c:530:92: macro "jffs2_sum_scan_sumnode" passed 5 
arguments, but takes just 4
fs/jffs2/scan.c: In function `jffs2_scan_eraseblock':
fs/jffs2/scan.c:530: error: `jffs2_sum_scan_sumnode' undeclared (first 
use in this function)
fs/jffs2/scan.c:530: error: (Each undeclared identifier is reported only 
once
fs/jffs2/scan.c:530: error: for each function it appears in.)
make[2]: *** [fs/jffs2/scan.o] Error 1
make[1]: *** [fs/jffs2] Error 2
make: *** [fs] Error 2
