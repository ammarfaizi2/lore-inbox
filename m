Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266338AbUGJSdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266338AbUGJSdj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 14:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUGJSdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 14:33:39 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:2946 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S266338AbUGJSdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 14:33:31 -0400
Message-ID: <40F03665.90108@tlinx.org>
Date: Sat, 10 Jul 2004 11:33:09 -0700
From: L A Walsh <lkml@tlinx.org>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: L A Walsh <lkml@tlinx.org>,
       Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <40EEC9DC.8080501@tlinx.org> <20040709215955.GA24857@taniwha.stupidest.org>
In-Reply-To: <20040709215955.GA24857@taniwha.stupidest.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My cases have been "vim" edited files.  I'd sorta think once vim has 
exited, the
data has been flushed, but that's just a WAG...

-l

Chris Wedgwood wrote:

>On Fri, Jul 09, 2004 at 09:37:48AM -0700, L A Walsh wrote:
>
>>ven after multiple syncs, files edited within the past few days
>>will sometimes go mysteriously null.  Good reason to do daily
>>backups as the backups will usually contain the correct file...
>>    
>>
>I *never* see this even when beating the hell out of machines and
>trying to break things.
>
>I do see nulls in cases where the metadata was updated and the data
>didn't flush, that's supposed to happen.
>  
>
>>Now if we could just come up with a reproducable test case...but
>>when I try to reproduce it, it doesn't.  Grrr....it knows when I'm
>>scrutinizing!! :-)
>>    
>>
>Use anything that handles dotfiles or configuration badly (ie. KDE),
>make some changes or just 'run it' for a bit.  Every now something
>rewrites some files.  Yank the power a few times and sooner or later
>you'll end up with problems under KDE certainly.
>  
>
---
    No desktop on this machine...it's a server I log into remotely for 
the most part.

