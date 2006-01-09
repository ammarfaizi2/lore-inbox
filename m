Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWAIMsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWAIMsq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 07:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWAIMsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 07:48:46 -0500
Received: from main.gmane.org ([80.91.229.2]:63884 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932261AbWAIMsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 07:48:45 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [PATCH] It's UTF-8
Date: Mon, 09 Jan 2006 21:48:25 +0900
Message-ID: <dptm2p$56k$1@sea.gmane.org>
References: <20060108203851.GA5864@mipter.zuzino.mipt.ru> <Pine.LNX.4.61.0601082245090.17804@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060103)
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.61.0601082245090.17804@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> 
> I'd say ACK. However,
> 
> 
>>iocharset=name	Character set to use for converting from Unicode to
>>		ASCII.  The default is to do no conversion.  Use
>>-		iocharset=utf8 for UTF8 translations.  This requires
>>+		iocharset=utf8 for UTF-8 translations.  This requires
>>		CONFIG_NLS_UTF8 to be set in the kernel .config file.
> 
> 
> If you are really nitpicky about the "-", then it should also be 
> "iocharset=utf-8" (and whereever else). Or what's the real purpose of 
> adding the dashes in only half of the places, then?

glibc was the starter, AFAIR. So both utf8 and UTF-8 are generally accepted, but utf-8 is not that
wide spread.

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

