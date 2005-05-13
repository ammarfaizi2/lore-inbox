Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbVENABg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbVENABg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 20:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbVENABg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 20:01:36 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:28993 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262628AbVENABT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 20:01:19 -0400
Date: Fri, 13 May 2005 17:59:49 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Sync option destroys flash!
In-reply-to: <43MVz-2hL-1@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42853F75.8030408@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <43Ldl-NM-25@gated-at.bofh.it> <43M9s-1B8-39@gated-at.bofh.it>
 <43MCx-1UF-27@gated-at.bofh.it> <43MVz-2hL-1@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
 > Well perhaps what windows does is write the hole file, then update the
 > fat, then call sync immediately afterwards, or whenever a file is
 > closed, it calls sync on that file's information.

Probably something like that.. Windows does default to disabling write 
caching on removable drives, to prevent data loss if a device is removed 
without being stopped first, but I think it's quite a bit less 
aggressive about updating the FAT than the original poster's description 
suggests Linux is doing with the sync option (i.e. only updating after 
each user-level write call or something).

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

