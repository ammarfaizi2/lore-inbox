Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932778AbWAHWJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbWAHWJX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 17:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932780AbWAHWJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 17:09:23 -0500
Received: from main.gmane.org ([80.91.229.2]:17291 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932779AbWAHWJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 17:09:22 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [PATCH] It's UTF-8
Date: Sun, 08 Jan 2006 22:09:08 +0000
Message-ID: <yw1xace69xtn.fsf@ford.inprovide.com>
References: <20060108203851.GA5864@mipter.zuzino.mipt.ru> <Pine.LNX.4.61.0601082245090.17804@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82.153.166.94
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:paerg/IAiK0Lq5nF9HJKy0AWjNo=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>
> I'd say ACK. However,
>
>> iocharset=name	Character set to use for converting from Unicode to
>> 		ASCII.  The default is to do no conversion.  Use
>>-		iocharset=utf8 for UTF8 translations.  This requires
>>+		iocharset=utf8 for UTF-8 translations.  This requires
>> 		CONFIG_NLS_UTF8 to be set in the kernel .config file.
>
> If you are really nitpicky about the "-", then it should also be 
> "iocharset=utf-8" (and whereever else). Or what's the real purpose of 
> adding the dashes in only half of the places, then?

The patch only changes documentation/comments.  Changing other things
would break compatibility, and that's usually not a good idea for
cosmetic changes.

-- 
Måns Rullgård
mru@inprovide.com

