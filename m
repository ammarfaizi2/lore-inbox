Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945930AbWBCTz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945930AbWBCTz7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945932AbWBCTz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:55:59 -0500
Received: from main.gmane.org ([80.91.229.2]:13722 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1945930AbWBCTz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:55:57 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alexander Fieroch <fieroch@web.de>
Subject: Re: [2.6.16rc2] compile error
Date: Fri, 03 Feb 2006 20:54:41 +0100
Message-ID: <ds0ce1$dma$1@sea.gmane.org>
References: <ds08vk$hk$1@sea.gmane.org> <87d5i48dxg.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: osten.wh.uni-dortmund.de
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: de-de, en-us, en
In-Reply-To: <87d5i48dxg.fsf@sycorax.lbl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Romosan wrote:
> look at /dev/null. on my system it keeps getting replaced by a regular
> file. not really sure where the bug is, but 'cd /dev; ./MAKEDEV null'
> will recreate the null character device and then the compilation will
> proceed normally.
> 
> --alex--

Thanks, that's it. /dev/null was replaced by a regular file.
Hm, /dev/MAKEDEV null and /dev/MAKEDEV std didn't rebuild the character
device null... but a reboot did.

Regards,
Alexander

