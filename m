Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVCaEcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVCaEcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 23:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVCaEcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 23:32:50 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:22826 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261964AbVCaEcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 23:32:48 -0500
Date: Wed, 30 Mar 2005 22:32:47 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: AMD64 Machine hardlocks when using memset
In-reply-to: <3NVqb-1iK-33@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <424B7D6F.7080601@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3NTHD-8ih-1@gated-at.bofh.it> <3NVqb-1iK-33@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias-Christian Ott wrote:
> You want to allocate a lot of memory (16 GB), you don't have that much 
> space, so the Kernel hangs.

No, this is not what it is doing. The program is simply wiping the same 
1MB block of memory over and over. If it was doing what you say it would 
not (or should not) lock the machine anyway.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

