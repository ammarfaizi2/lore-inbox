Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbVJSXVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbVJSXVT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 19:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbVJSXVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 19:21:19 -0400
Received: from mail02.birthdayalarm.com ([207.7.149.42]:13277 "EHLO
	mail02.birthdayalarm.com") by vger.kernel.org with ESMTP
	id S1751632AbVJSXVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 19:21:19 -0400
Message-ID: <4356D55D.5060303@birthdayalarm.com>
Date: Wed, 19 Oct 2005 16:23:09 -0700
From: Dave Pifke <dave@birthdayalarm.com>
Organization: Birthday Alarm, LLC
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about buffer usage
References: <4356C1B2.3070401@bebo.com> <20051019154940.55f18786.akpm@osdl.org>
In-Reply-To: <20051019154940.55f18786.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

 > It could be a JFS quirk - I don't know much about JFS.  It'd be 
interesting
 > to know if other filesystems behave in a similar manner.

I have two more machines on order, so perhaps I'll try a different 
filesystem on them and report back if it makes a difference.

 > One thing you could do is to (re)mount the filesystems with `-o noatime'.

I probably should have mentioned that this is already the case.

 > That should release _some_ of the blockdev pagecache, but not a lot, I
 > expect.  Maybe JFS is just metadata-intensive..

There appears to be a jfs-discussion mailing list on SourceForge; I'll 
try asking there.


-- 
Dave Pifke, dave@bebo.com
Sr. System Administrator, www.bebo.com
