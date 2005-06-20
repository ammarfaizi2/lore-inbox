Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVFTCCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVFTCCs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 22:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVFTCCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 22:02:48 -0400
Received: from mail.dvmed.net ([216.237.124.58]:54423 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261380AbVFTCCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 22:02:47 -0400
Message-ID: <42B623C1.7070004@pobox.com>
Date: Sun, 19 Jun 2005 22:02:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org, sam@ravnborg.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.12] Add -Wno-pointer-sign to HOSTCFLAGS
References: <20663.1119145803@ocs3.ocs.com.au>
In-Reply-To: <20663.1119145803@ocs3.ocs.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> Compiling 2.6.12 with gcc 4.0.0 (FC4) gets lots of warnings for the
> programs in the scripts directory.  Add -Wno-pointer-sign to HOSTCFLAGS
> to suppress them.
> 
> Signed-off-by: Keith Owens <kaos@ocs.com.au>


Although I am a bit nervous about papering over these warnings without 
addressing them...  I still ACK the patch, because gcc4 on FC4 does 
indeed spew a bunch of noise.

Have you (or anyone) looked into the "root cause" of these warnings?

	Jeff


