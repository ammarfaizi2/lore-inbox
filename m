Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUDEE51 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 00:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263114AbUDEE51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 00:57:27 -0400
Received: from cache.dfw.ygnition.net ([66.135.176.7]:25793 "EHLO
	cache.dfw.interquest.net") by vger.kernel.org with ESMTP
	id S263107AbUDEE5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 00:57:21 -0400
Message-ID: <4070E72D.7090702@tvmax.net>
Date: Sun, 04 Apr 2004 23:57:17 -0500
From: Kyle Davenport <kdd@tvmax.net>
Organization: Davenport Consulting
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.25 crashes windows
References: <Pine.LNX.4.44.0404042132201.28197-100000@cola.local>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Urban Widmark wrote:

>On Sun, 4 Apr 2004, Kyle Davenport wrote:
>
>  
>
>>No joke.  64-bit Windows Advanced Server 2003 blue-screens on file share
>>access.  I was using Samba 3.0 on RH8 to routinely access windows
>>shares.  When I upgraded from 2.4.22 to 2.4.25, any attempt to access a
>>sub-directory of a share mounted from 64-bit Win2003, immediately
>>crashes windows.  I rolled back to 2.4.22 and no crash.  I tried 2.4.25
>>against a 32-bit 2003 Win2003, and no crash.  I didn't test different
>>versions of Samba.  But on 2.4.25, trying to ls a sub-directory of the
>>mounted share or cd to that sub-directory, instantly and repeatedly
>>blue-screens windows.  
>>    
>>
>
>When you say mount, does that mean smbfs?
>  
>
yes.

>2.4.25 allows you to enable the cifs unix extensions in smbfs. Perhaps
>turning those off makes a difference?
>
>The other change is that smbfs in 2.4.25 has large file support. smbfs in 
>2.4.24 should behave like 2.4.22.
>
ok, I'll try that tomorrow. Any idea what those directives are?



-- 
Kyle Davenport - unix sys admin consultant - Dallas TX
_____________________________
You can lead a horse to knowledge, but you can not make him learn it.





