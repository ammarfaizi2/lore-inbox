Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268097AbUIKLj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268097AbUIKLj4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 07:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268108AbUIKLj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 07:39:56 -0400
Received: from pointblue.com.pl ([81.219.144.6]:24332 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S268097AbUIKLja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 07:39:30 -0400
Message-ID: <4142E3EB.3080308@pointblue.com.pl>
Date: Sat, 11 Sep 2004 13:39:23 +0200
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Jakob Oestergaard <jakob@unthought.net>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Major XFS problems...
References: <20040908123524.GZ390@unthought.net>
In-Reply-To: <20040908123524.GZ390@unthought.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Oestergaard wrote:

><frustrated_admin mode="on">
>
>Does anyone actually use XFS for serious file-serving?  (yes, I run it
>on my desktop at home and I don't have problems there - such reports are
>not really relevant).
>
>Is anyone actually maintaining/bugfixing XFS?  Yes, I know the
>MAINTAINERS file, but I am a little bit confused here - seeing that
>trivial-to-trigger bugs that crash the system and have simple fixes,
>have not been fixed in current mainline kernels.
>
>If XFS is a no-go because of lack of support, is there any realistic
>alternatives under Linux (taking our need for quota into account) ?
>
>And finally, if Linux is simply a no-go for high performance file
>serving, what other suggestions might people have?  NetApp?
>
></>
>
>  
>
In my expierence XFS, was right after JFS the worst and the slowest 
filesystem ever made.
Since than, I am using reiserfs 3.6. I don't need quota for my servers, 
but there is patch avaliable for it I belive, from SuSE.
ReiserFS is da most reliable FS for linux (with journaling). If you 
don't need journaling, ext2 is da choice.

--
GJ

