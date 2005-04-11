Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVDKEGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVDKEGz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 00:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVDKEGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 00:06:55 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:19776 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261684AbVDKEGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 00:06:53 -0400
Date: Sun, 10 Apr 2005 22:03:30 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: formatting CD-RW locks the system
In-reply-to: <3RXML-BZ-15@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4259F712.4070802@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3RPvT-2g8-31@gated-at.bofh.it> <3RRo1-3O4-21@gated-at.bofh.it>
 <3RXML-BZ-15@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev wrote:
> OK, I'll try cdrecord too, thanks.
> But there might be a bug in the kernel
> if the system literally dies with the
> cdrwtool.

If the format is being done as a single blocking ATAPI command, then 
that will definitely block any other accesses on the same IDE channel, 
at least - that's just the way IDE works. That shouldn' have an effect 
on other IDE channels though..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

