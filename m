Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267033AbUBSIOr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 03:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267055AbUBSIOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 03:14:47 -0500
Received: from tartutest.cyber.ee ([193.40.6.70]:4357 "EHLO tartutest.cyber.ee")
	by vger.kernel.org with ESMTP id S267033AbUBSIOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 03:14:44 -0500
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Reply-To: netdev@oss.sgi.com
Subject: Re: [NET] 64 bit byte counter for 2.6.3
In-Reply-To: <20040218101711.25dda791@dell_ss3.pdx.osdl.net>
User-Agent: tin/1.7.4-20040111 ("Taransay") (UNIX) (Linux/2.6.3 (i686))
Message-Id: <E1AtjKh-0006Bz-Ee@rhn.tartu-labor>
Date: Thu, 19 Feb 2004 10:14:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SH>  * Network changes gets discussed on netdev@oss.sgi.com 
SH>  * 64 bit values are not atomic on 32 bit architectures 

Agree.

SH>  * wider values in /proc output risks breaking apps like ifconfig and netstat

This is probably not a problem here, ifconfig etc have been working fine
with non-wrapping numbers on sparc64 and other 64-bit machines.

-- 
Meelis Roos
